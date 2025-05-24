<template>
  <div>
    <div id="card-form"></div>  <!-- 这里是 Payjp 卡片挂载的地方 -->
    <button @click="createToken">支付</button>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import request from '@/utils/request.js'

// ⚠️ 换成你自己的公钥
const payjp = window.Payjp('pk_test_f23f4fdae117d68ca6d3fa74')
const elements = payjp.elements()
const card = elements.create('card')
const token = ref('')

onMounted(() => {
  card.mount('#card-form')
})

function createToken() {
  payjp.createToken(card).then((response) => {
    if (response.error) {
      alert('错误：' + response.error.message)
    } else {
      token.value = response.id
      console.log('生成的 Token:', response.id)

      // ✅ 调用你后端的下单接口
      request({
        url: '/orders',
        method: 'post',
        data: {
          payjpToken: token.value,
          // 可以添加其他字段，如商品 ID、数量等
        }
      }).then(() => {
        alert('支付成功！')
      }).catch(() => {
        alert('支付失败，请检查后端接口。')
      })
    }
  })
}
</script>
