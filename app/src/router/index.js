import { createRouter, createWebHistory } from "vue-router";
import AboutView from "../views/AboutView.vue";
import SearchView from "@/views/SearchView.vue";
import Checkout from "@/views/Checkout.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: AboutView,
    },
    {
      path: "/search",
      name: "search",
      component: SearchView,
    },
    {
      path: "/checkout",
      name: "checkout",
      component: Checkout,
    },
    {
      path: "/store/:storeId",
      name: "store",
      component: () => import("../views/SelectedStore.vue"),
    },
    {
      path: "/profile/:userName",
      name: "profile",
      component: () => import("../views/ProfileView.vue"),
    },
    {
      path: "/no-user",
      name: "no-user",
      component: () => import("../views/NoUser.vue"),
    },
    {
      path: "/about",
      name: "about",
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import("../views/AboutView.vue"),
    },
  ],
});

export default router;
