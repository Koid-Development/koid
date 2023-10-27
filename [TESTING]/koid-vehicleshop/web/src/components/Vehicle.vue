<script lang="ts">
import { useShopStore } from '../store/shop';

export default {
    name: 'Vehicle List',
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
    }
}
</script>

<template>
    <div class="grid grid-flow-row max-h-[25vw] w-full pr-3 space-y-3 overflow-y-scroll vehicles">
        <div v-for="car, key in shopStore.getFilteredVehicles" :key="key"
            v-if="!shopStore.loading"
            @click="shopStore.setCurrentVehicle(car)"
            :class="[shopStore.currentVehicle.name === car.name ? 'bg-opacity-70' : 'bg-opacity-30']"
            class="flex flex-row items-center justify-between min-h-24 px-8 py-4 transition-all ease-in-out bg-[#2f2f2f] rounded-md cursor-pointer vehicle bg-opacity-30 hover:bg-opacity-100">
            <div class=" left">
                <div class="text-lg name">
                    <span>{{ car.name }}</span>
                </div>
                <div class="mt-2 text-xs uppercase">
                    <span class="px-2 rounded-lg bg-white/10">{{ car.category }}</span>
                </div>
            </div>
            <div class="right">
                <div class="text-green-400 price">
                    <span class="text-lg">{{ shopStore.translation.currency }}{{ numberWithCommas(car.price) }}</span>
                </div>
            </div>
        </div>
    </div>
</template>
