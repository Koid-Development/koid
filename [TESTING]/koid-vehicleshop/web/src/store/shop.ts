import {defineStore} from 'pinia'
import { IStore } from '../interfaces/IStore'
import { IVehicle } from '../interfaces/IVehicle'
import { ITranslation } from '../interfaces/ITranslation'
import Callback from '../nui'

export const useShopStore = defineStore({
    id: 'shop',
    state: () => ({
        store: {
            name: 'Tienda de vehiculos altas velocidades',
            description: 'En este concesionario podrás encontrar los vehiculos más veloces de toda la ciudad!'
        } as IStore,
        vehicles: [
            {
                name: 'MiPollaEnMoto',
                model: 'mipollaenmoto',
                price: 100000,
                category: 'sports'
            },
            {
                name: 'MiPollaEnMoto1',
                model: 'mipollaenmoto1',
                price: 100000,
                category: 'sports'
            },
            {
                name: 'MiPollaEnMoto2',
                model: 'mipollaenmoto2',
                price: 100000,
                category: 'sports'
            },
            {
                name: 'MiPollaEnMoto3',
                model: 'mipollaenmoto3',
                price: 100000,
                category: 'sports'
            },
            {
                name: 'MiPollaEnMoto4',
                model: 'mipollaenmoto4',
                price: 100000,
                category: 'sports'
            },
            {
                name: 'MiPollaEnMoto2',
                model: 'mipollaenmoto2',
                price: 100000,
                category: 'sports'
            },
            {
                name: 'MiPollaEnMoto3',
                model: 'mipollaenmoto3',
                price: 100000,
                category: 'sports'
            },
            {
                name: 'MiPollaEnMoto4',
                model: 'mipollaenmoto4',
                price: 100000,
                category: 'sports'
            },
        ] as IVehicle[],
        translation: {
            purchase: 'Comprar',
            currency: '€',
        } as ITranslation,
        categories: [
            'sports',
            'super',
            'armored',
            'offroad'
        ] as string[],
        currentVehicle: {
            name: 'Sultan RS',
            model: 'sultanrs',
            price: 100000,
            category: 'sports'
        } as IVehicle,
        currentCategory: 'sports',
        loading: false,
    }),
    getters: {
        getStore: (state) => state.store,
        getVehicles: (state) => state.vehicles,
        getTranslation: (state) => state.translation,
        getFilteredVehicles: (state) => {
            if (state.currentCategory === 'clear') {
                return state.vehicles
            }
            return state.vehicles.filter((vehicle) => vehicle.category === state.currentCategory)
        }
    },
    actions: {
        setStore(store: IStore) {
            this.store = store
        },
        setVehicles(vehicles: IVehicle[]) {
            this.vehicles = vehicles
        },
        setCurrentVehicle(vehicle: IVehicle) {
            this.currentVehicle = vehicle
            this.loading = true
            Callback('selectCar', {vehicle: vehicle.model})
        },
        setTranslation(translation: ITranslation) {
            this.translation = translation
        },
        setCategories(categories: string[]) {
            this.categories = categories
        },
        setCategory(category: string) {
            this.currentCategory = category
        },
        resetData() {
            this.store = { name: '', description: '' }
            this.vehicles = []
            this.translation = { purchase: '', currency: '', exit: '' }
            this.currentCategory = 'clear'
            // @ts-ignore
            this.currentVehicle = {}
            this.categories = []
        }
    }
})