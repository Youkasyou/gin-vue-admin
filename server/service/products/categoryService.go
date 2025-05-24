package products

import (
	"sort"
	"strconv"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/dto"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/products"
)

type CategoryService struct{}

func (categoryService *CategoryService) GetTree(maxDepth int) (res []dto.CategoryTreeNode, err error) {
	categories := []products.Category{}
	err = global.GVA_DB.Find(&categories).Error
	if err != nil {
		return nil, err
	}
	cateRes := []*dto.CategoryTreeNode{}
	nodeMap := make(map[int]*dto.CategoryTreeNode)
	for _, v := range categories {
		nodeMap[v.ID] = &dto.CategoryTreeNode{
			CategoryID: strconv.Itoa(v.ID),
			Name:       v.Name,
			Level:      v.Level,
		}
	}

	for _, v := range categories {
		if v.Level == 0 {
			cateRes = append(cateRes, nodeMap[v.ID])
		} else {
			if maxDepth == 0 || maxDepth > v.Level {
				nodeMap[*v.ParentID].Children = append(nodeMap[*v.ParentID].Children, nodeMap[v.ID])
			}
		}
	}

	resCate := []dto.CategoryTreeNode{}
	for _, node := range cateRes {
		resCate = append(resCate, *node)
	}

	return resCate, err
}
func (categoryService *CategoryService) GetInfo(categoryId int, isCount bool, isAttr bool) (res *dto.CategoryDetailResponse, err error) {
	catInfo := &dto.CategoryInfoBasic{}
	global.GVA_DB.Table("categories").
		Select(`CONVERT(id, CHAR) as category_id,name,description,level,parent_id`).
		Where("id = ? ", categoryId).Scan(&catInfo)
	if catInfo.CategoryID == "" {
		return nil, response.ErrNotFound
	}

	breadcrumbs := []dto.BreadcrumbItem{}
	if catInfo.ParentID != nil {
		currentId, _ := strconv.Atoi(*catInfo.ParentID)
		for currentId != 0 {
			currentCategory := &products.Category{}
			err := global.GVA_DB.Find(&currentCategory, currentId).Error
			if err != nil {
				return nil, err
			}
			if currentCategory.ParentID != nil {
				currentId = *currentCategory.ParentID
			} else {
				currentId = 0
			}
			breadcrumbs = append([]dto.BreadcrumbItem{{
				CategoryID: strconv.Itoa(currentCategory.ID),
				Name:       currentCategory.Name,
				Level:      currentCategory.Level,
			}}, breadcrumbs...)
		}
	}
	breadcrumbs = append(breadcrumbs, dto.BreadcrumbItem{
		CategoryID: catInfo.CategoryID,
		Name:       catInfo.Name,
		Level:      catInfo.Level,
	})

	subCategories := []dto.SubCategoryInfo{}

	global.GVA_DB.Raw(` with recursive sub_tree as (
		select id,name,id as top_node_id
		from categories
		where parent_id = ?
		
		union all
		
		select c.id,c.name,st.top_node_id
		from categories c
	join sub_tree st on c.parent_id = st.id
	)

	select CONVERT(st.top_node_id, CHAR) as category_id,c2.name,count(p.id) as product_count
	from sub_tree st
	join categories c2 on c2.id = st.top_node_id
	left join products p on st.id = p.category_id
	group by st.top_node_id,c2.name`, categoryId).
		Scan(&subCategories)

	filterAttrEntity := []dto.FilterableAttributeEntity{}
	global.GVA_DB.Table("category_attributes ca").
		Select(`a.id as attribute_id,a.name as attribute_name,a.attribute_code,
	ao.id as option_id,ao.value as option_value,count(DISTINCT ps.product_id) as product_count`).
		Joins("left join attributes a on ca.attribute_id = a.id").
		Joins("left join attribute_options ao on ao.attribute_id = ca.attribute_id").
		Joins("left join products p on p.category_id = ca.category_id").
		Joins("left join sku_values sv on sv.option_id = ao.id").
		Joins("left join product_skus ps on ps.id = sv.sku_id and ps.product_id = p.id").
		Where("ca.category_id = ? and a.is_filterable = 1", categoryId).
		Group("a.id,a.name,a.attribute_code,ao.id ,ao.value").
		Scan(&filterAttrEntity)

	filterAttrMap := make(map[int]*dto.FilterableAttributeInfo)
	optionMap := make(map[int]map[int]struct{})
	for _, v := range filterAttrEntity {
		if _, ok := filterAttrMap[v.AttributeID]; !ok {
			filterAttrMap[v.AttributeID] = &dto.FilterableAttributeInfo{
				AttributeID:   v.AttributeID,
				AttributeName: v.AttributeName,
				AttributeCode: v.AttributeCode,
				Options:       []dto.FilterableOptionItem{},
			}
			optionMap[v.AttributeID] = make(map[int]struct{})
		}
		if _, ok := optionMap[v.AttributeID][v.OptionID]; !ok {
			filterAttrMap[v.AttributeID].Options = append(filterAttrMap[v.AttributeID].Options, dto.FilterableOptionItem{
				OptionID:     v.OptionID,
				OptionValue:  v.OptionValue,
				ProductCount: v.ProductCount,
			})
			optionMap[v.AttributeID][v.OptionID] = struct{}{}
		}
	}

	catRes := &dto.CategoryDetailResponse{}
	if isAttr {
		for _, v := range filterAttrMap {
			catRes.FilterableAttributes = append(catRes.FilterableAttributes, *v)
		}
		sort.Slice(catRes.FilterableAttributes, func(i, j int) bool {
			return catRes.FilterableAttributes[i].AttributeID < catRes.FilterableAttributes[j].AttributeID // 升序
		})
	}

	catRes.CategoryInfo = catInfo
	catRes.Breadcrumbs = breadcrumbs

	var total_count int
	if len(subCategories) != 0 {
		for _, v := range subCategories {
			total_count += *v.ProductCount
		}
		catRes.TotalProductsInCategory = &total_count
	} else {
		global.GVA_DB.Table("categories c").Select("count(p.id)").
			Joins("left join products p on p.category_id = c.id").Where("c.id = ?", categoryId).Scan(&total_count)
		catRes.TotalProductsInCategory = &total_count
	}

	if !isCount {
		for k := range subCategories {
			subCategories[k].ProductCount = nil
		}
	}
	catRes.SubCategories = subCategories

	return catRes, err
}
