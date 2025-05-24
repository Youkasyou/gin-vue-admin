package core

import (
	"context"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/olivere/elastic/v7"
)

// func InitElasticSearch() *elastic.Client {
// 	options := []elastic.ClientOptionFunc{
// 		elastic.SetURL(global.GVA_CONFIG.ES.Host),
// 		elastic.SetSniff(false),
// 	}

// 	// // 如果需要认证
// 	// if global.GVA_CONFIG.ES.Username != "" {
// 	// 	options = append(options, elastic.SetBasicAuth(global.GVA_CONFIG.ES.Username, global.GVA_CONFIG.ES.Password))
// 	// }

// 	client, err := elastic.NewClient(options...)
// 	if err != nil {
// 		log.Fatalf("Elasticsearch init error: %v", err)
// 		os.Exit(1)
// 	}
// 	return client
// }

func InitElasticSearch() *elastic.Client {
	cfg := global.GVA_CONFIG.ES

	client, err := elastic.NewClient(
		elastic.SetURL(cfg.Host),
		//elastic.SetBasicAuth(cfg.Username, cfg.Password),
		elastic.SetSniff(false),
	)
	if err != nil {
		panic("❌ Elasticsearch 连接失败: " + err.Error())
	}

	// 测试连接
	_, _, err = client.Ping(cfg.Host).Do(context.Background())
	if err != nil {
		panic("❌ Elasticsearch Ping 测试失败: " + err.Error())
	}

	global.GVA_LOG.Info("✅ Elasticsearch 初始化成功")
	return client
}
