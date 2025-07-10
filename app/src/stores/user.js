import { orders } from "@/assets/user";
import { useAuthStore } from "@/stores/auth";
import { defineStore } from "pinia";

export const useUserStore = defineStore("user", {
  state: () => ({
    user: null,
    orders: [],
    reviews: [],
  }),
  actions: {
    async fetchUser() {
      const authStore = useAuthStore();
      const { currentUser } = authStore;
      if (currentUser) {
        this.user = currentUser;
      }
    },
    //   if the user exists we fetch the user's data

    async fetchOrders() {
      const authStore = useAuthStore();
      const { currentUser } = authStore;
      if (currentUser) {
        this.orders = orders;
      } else {
        this.orders = [];
      }
    },

    async fetchReviews() {
      const authStore = useAuthStore();
      const { currentUser } = authStore;
      if (currentUser) {
        this.reviews = [];
      } else {
        this.reviews = [];
      }
    },
  },
});
