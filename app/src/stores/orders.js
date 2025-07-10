import { defineStore } from "pinia";
import { ServerClient } from "./auth";

export const useOrderStore = defineStore("orders", {
  state: () => ({
    cart: [],
    orders: [],
    checkOut: [],
    cartIsEmpty: true,
    addresses: [],
    addressDialogOpen: false,
    selectedAddressId: null,
  }),

  actions: {
    addToCart(item) {
      //we check for duplicates
      if (this.cart.some((cartItem) => cartItem.id === item.id)) {
        return;
      }
      this.cart.push(item);
      this.cartIsEmpty = false;
    },
    removeFromCart(item) {
      this.cart = this.cart.filter((cartItem) => cartItem.id !== item.id);
      this.cartIsEmpty = this.cart.length === 0;
    },
    addToCheckOut(items) {
      this.checkOut.push(...items);
    },

    async addNewAddress(street, city, state, zip, country) {
      try {
        const payload = {
          street: street,
          city: city,
          state: state,
          zip: zip,
          country: country,
          latitude: 0,
          longitude: 0,
        };
        await ServerClient.post("/createAddress", payload);
        await this.fetchAllAddresses();
      } catch (error) {
        console.log(error);
      }
    },
    async fetchAllAddresses() {
      try {
        const response = await ServerClient.get("/fetchAllAddresses");
        this.addresses = response.data;
      } catch (error) {
        console.log(error);
      }
    },

    async CreateOrder({ storeId, addressId, itemIds }) {
      try {
        await ServerClient.post("/createOrder", {
          storeId: storeId,
          addressId: addressId,
          itemIds: itemIds,
        });
        this.checkOut = [];
        this.cart = [];
      } catch (error) {
        throw new Error(error);
      }
    },

    async fetchAllOrders() {
      try {
        const response = await ServerClient.get("/fetchAllOrders");
        return response.data;
      } catch (error) {
        throw new Error(error);
      }
    },

    openAddressDialog(mode) {
      this.addressDialogOpen = mode;
      this.addressDialogOpen = true;
    },

    closeAddressDialog() {
      this.addressDialogOpen = false;
    },

    selectAddress(addressId) {
      this.selectedAddressId = addressId;
    },
  },
});
