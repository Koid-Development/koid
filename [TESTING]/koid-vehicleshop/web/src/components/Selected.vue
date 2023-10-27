<script lang="ts">
import postData from '../nui'
import {useShopStore} from '../store/shop';

export default {
  name: 'Selected Vehicle',
  setup() {
    const shopStore = useShopStore()

    return {
      shopStore
    }
  },
  methods: {
    numberWithCommas(x: Number) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
    purhcase() {
      postData('purchase', {vehicle: this.shopStore.currentVehicle.model}).then((bool: boolean) => {
        if (bool) {
          postData('closeShop')
        }
      })
    }
  }
}
</script>

<template>
  <div v-if="Object.keys(shopStore.currentVehicle).length > 0"
       class="flex flex-col items-center w-full space-y-3 purchase">
    <div class="text-white price">
      <span class="text-2xl font-medium">{{
          shopStore.translation.currency
        }}{{ numberWithCommas(shopStore.currentVehicle.price) }}</span>
    </div>
    <div class="flex flex-row items-center space-x-4">
      <div @click="purhcase"
           class="px-8 py-2 w-[9vw] text-white text-center transition-all ease-in-out transform bg-[#3f3f3f] rounded-lg cursor-pointer purchase-btn hover:scale-105 hover:bg-[#0f0f0f]">
        <span> {{ shopStore.translation.purchase }} </span>
      </div>
      <div @click="$emit('startTimer')"
           class="px-8 py-2 w-[9vw] text-white text-center transition-all ease-in-out transform bg-[#3f3f3f] rounded-lg cursor-pointer purchase-btn hover:scale-105 hover:bg-[#0f0f0f]">
        <span>Probar</span>
      </div>
    </div>
  </div>
</template>