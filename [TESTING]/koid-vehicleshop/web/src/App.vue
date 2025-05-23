<script lang="ts">
import {useShopStore} from './store/shop';
import Categories from './components/Categories.vue';
import Vehicles from './components/Vehicle.vue';
import Selected from './components/Selected.vue';
import Timer from './components/Timer.vue';
import Nui from './nui'
import MouseIcon from './assets/mouse.svg'

export default {
  name: 'Vehicle Shop',
  components: {
    Categories,
    Vehicles,
    Selected,
    Timer
  },
  emits: ['startTimer'],
  data() {
    return {
      display: false,
      loading: false,
      holding: false,
      oldx: 0,
      mouseDirection: '',
      timer: {
        show: false,
        time: 0,
      },
      mouseIcon: MouseIcon
    }
  },
  mounted() {
    window.addEventListener('message', (event) => {
      let data = event.data
      switch (data.type) {
        case 'open':
          this.display = true;
          console.log(JSON.stringify(data, null, 2))
          const category = data.shop.category;
          if (category instanceof Array) {
            category.push('clear');
          }
          this.shopStore.setStore({name: data.shop.name, description: data.shop.description});
          this.shopStore.setCategories(category);
          this.shopStore.setTranslation(data.translation);
          this.shopStore.setVehicles(data.cars);
          break;
        case 'loadingDone':
          this.shopStore.loading = false;
          break;
        case 'startTimer':
          this.timer.show = true;
          this.timer.time = data.time;
          break;
        case 'stopTimer':
          this.timer.show = false;
          break;
        case 'close':
          this.display = false;
          break;
      }
    })
  },
  created() {
    let that = this;
    document.addEventListener('mousemove', that.NUIMouseMove)
    document.addEventListener('mousedown', () => that.holding = true)
    document.addEventListener('mouseup', () => that.holding = false)
    document.addEventListener('keyup', function (evt) {
      if (evt.keyCode === 27) {
        that.close();
      }
    });
  },
  methods: {
    NUIMouseMove(e: any) {
      if (e.pageX < this.oldx) {
        this.mouseDirection = 'left'
      } else {
        this.mouseDirection = 'right'
      }
      this.oldx = e.pageX
      if (this.mouseDirection == "left" && this.holding) {
        if (e.target.classList.contains("main-shop")) {
          Nui('rotateVeh', {type: 'right'})
        }
      }
      if (this.mouseDirection == "right" && this.holding) {
        if (e.target.classList.contains("main-shop")) {
          Nui('rotateVeh', {type: 'left'})
        }
      }
    }, close() {
      this.display = false
      this.shopStore.resetData()
      Nui('closeShop');
    },
    startTest() {
      console.log('test drive')
      Nui('testDrive', {vehicle: this.shopStore.currentVehicle.model}).then((bool: boolean) => {
        if (bool) {
          this.close()
        }
      })
    }
  },
  setup() {
    const shopStore = useShopStore()

    return {
      shopStore
    }
  }
}
</script>

<template>
  <div v-show="display"
       class="flex flex-col items-end justify-start w-full h-screen p-8 space-y-5 text-white main-shop">
    <div class="max-w-[380px] min-h-[46vw] bg-[#1f1f1f] rounded-md">
      <div v-motion-pop class="main-stuff w-[380px] p-4 flex flex-col space-y-6 relative items-start overflow-hidden">
        <div class="flex flex-row items-center space-x-3 exit-shop absolue left-12">
          <div class="flex flex-row items-center space-x-3 rotate escape">
            <div class="px-2 py-2 rounded-lg bg-white/20 w-10 h-10 text-center">
              <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 50 50"
                   style="fill:#FFFFFF;">
                <path
                    d="M 11 7 C 8.24 7 6 9.24 6 12 L 6 38 C 6 40.76 8.24 43 11 43 L 39 43 C 41.76 43 44 40.76 44 38 L 44 12 C 44 9.24 41.76 7 39 7 L 11 7 z M 25.089844 20.970703 C 26.029844 20.970703 26.789141 21.149531 27.369141 21.519531 C 27.959141 21.889531 28.300859 22.539219 28.380859 23.449219 L 26.429688 23.449219 C 26.409688 23.199219 26.340703 22.999609 26.220703 22.849609 C 26.010703 22.589609 25.640859 22.460938 25.130859 22.460938 C 24.700859 22.460938 24.400703 22.520391 24.220703 22.650391 C 24.040703 22.790391 23.949219 22.939141 23.949219 23.119141 C 23.949219 23.339141 24.040469 23.499609 24.230469 23.599609 C 24.430469 23.709609 25.099531 23.890625 26.269531 24.140625 C 27.039531 24.330625 27.629766 24.600703 28.009766 24.970703 C 28.399766 25.350703 28.589844 25.809141 28.589844 26.369141 C 28.589844 27.109141 28.309766 27.709687 27.759766 28.179688 C 27.209766 28.649687 26.360938 28.880859 25.210938 28.880859 C 24.040937 28.880859 23.169375 28.630625 22.609375 28.140625 C 22.049375 27.650625 21.769531 27.02 21.769531 26.25 L 23.75 26.25 C 23.79 26.6 23.879531 26.840234 24.019531 26.990234 C 24.259531 27.250234 24.709375 27.380859 25.359375 27.380859 C 25.749375 27.380859 26.049297 27.320938 26.279297 27.210938 C 26.509297 27.090937 26.619141 26.919453 26.619141 26.689453 C 26.619141 26.479453 26.529609 26.309219 26.349609 26.199219 C 26.159609 26.079219 25.480547 25.889375 24.310547 25.609375 C 23.460547 25.399375 22.859531 25.140312 22.519531 24.820312 C 22.169531 24.510313 22 24.060469 22 23.480469 C 22 22.790469 22.270547 22.200937 22.810547 21.710938 C 23.350547 21.210938 24.109844 20.970703 25.089844 20.970703 z M 17.550781 20.980469 C 18.200781 20.980469 18.790547 21.100078 19.310547 21.330078 C 19.830547 21.560078 20.259844 21.929688 20.589844 22.429688 C 20.899844 22.869688 21.099453 23.390703 21.189453 23.970703 C 21.239453 24.310703 21.26 24.809219 21.25 25.449219 L 15.830078 25.449219 C 15.860078 26.199219 16.119609 26.719531 16.599609 27.019531 C 16.899609 27.209531 17.259688 27.300781 17.679688 27.300781 C 18.119688 27.300781 18.479766 27.190938 18.759766 26.960938 C 18.909766 26.840937 19.050156 26.669219 19.160156 26.449219 L 21.150391 26.449219 C 21.100391 26.889219 20.859687 27.339063 20.429688 27.789062 C 19.759687 28.519063 18.829141 28.880859 17.619141 28.880859 C 16.629141 28.880859 15.76 28.580938 15 27.960938 C 14.24 27.350938 13.859375 26.360469 13.859375 24.980469 C 13.859375 23.690469 14.210625 22.699766 14.890625 22.009766 C 15.570625 21.319766 16.460781 20.980469 17.550781 20.980469 z M 33.119141 21 C 34.059141 21 34.819922 21.210859 35.419922 21.630859 C 36.009922 22.050859 36.370469 22.789609 36.480469 23.849609 L 34.480469 23.849609 C 34.440469 23.569609 34.349219 23.319609 34.199219 23.099609 C 33.979219 22.799609 33.639688 22.650391 33.179688 22.650391 C 32.519688 22.650391 32.070078 22.969141 31.830078 23.619141 C 31.700078 23.969141 31.640625 24.43 31.640625 25 C 31.640625 25.55 31.700078 25.990312 31.830078 26.320312 C 32.060078 26.940313 32.500625 27.25 33.140625 27.25 C 33.600625 27.25 33.929141 27.120859 34.119141 26.880859 C 34.309141 26.630859 34.430703 26.309922 34.470703 25.919922 L 36.460938 25.919922 C 36.410938 26.509922 36.200547 27.079609 35.810547 27.599609 C 35.200547 28.459609 34.299609 28.880859 33.099609 28.880859 C 31.899609 28.880859 31.009219 28.530312 30.449219 27.820312 C 29.879219 27.100313 29.599609 26.180781 29.599609 25.050781 C 29.599609 23.770781 29.909063 22.780313 30.539062 22.070312 C 31.159063 21.360312 32.019141 21 33.119141 21 z M 17.560547 22.589844 C 17.050547 22.589844 16.670625 22.729766 16.390625 23.009766 C 16.120625 23.299766 15.939141 23.679922 15.869141 24.169922 L 19.230469 24.169922 C 19.190469 23.649922 19.020937 23.260234 18.710938 22.990234 C 18.400938 22.720234 18.010547 22.589844 17.560547 22.589844 z"></path>
              </svg>
            </div>
            <span class="text-sm">Salir de la tienda</span>
          </div>
          <div class="flex flex-row items-center space-x-3 rotate">
            <div class="px-2 py-2 rounded-lg bg-white/20 w-10 h-10 text-center ">
              <i class="fa-duotone fa-computer-mouse-scrollwheel text-xl"
                 style="--fa-primary-opacity: 0.4; --fa-secondary-opacity: 1;"></i>
            </div>
            <span class="text-sm">Rotar vehiculo</span>
          </div>
        </div>
        <div class="top">
          <div class="text-3xl text-center font-medium title">
            <span class="">{{ shopStore.store.name }}</span>
          </div>
          <div class="description">
            <p class="text-sm text-center text-white/50">{{ shopStore.store.description }}</p>
          </div>
          <div class="categories">
            <Categories/>
          </div>
        </div>
        <Vehicles/>
        <Selected @startTimer="startTest"/>
      </div>
    </div>
  </div>
  <Timer v-if="timer.show" :time="timer.time"/>
</template>

<style>
/* width */
::-webkit-scrollbar {
  width: 5px;
}

/* Track */
::-webkit-scrollbar-track {
  background: #f1f1f159;
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: rgb(255, 255, 255);
}
</style>
