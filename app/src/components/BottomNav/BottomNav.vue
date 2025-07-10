<script setup>
import { computed, ref, watch } from "vue";
import { RouterLink } from "vue-router";
import { FlFilledHome } from "@kalimahapps/vue-icons";
import { FaCartShopping } from "@kalimahapps/vue-icons";
import { ChSearch } from "@kalimahapps/vue-icons";
import { BsPersonFill } from "@kalimahapps/vue-icons";
import CartView from "../Cart/CartView.vue";
import { useAuthStore } from "@/stores/auth";
import { useOrderStore } from "@/stores/orders";

const open = ref(false);
const authStore = useAuthStore();
const orderStore = useOrderStore();
const userName = ref("");
const checkout = ref([]);
const handleOpenCart = (item) => {
  open.value = true;
};

const handleCloseCart = () => {
  open.value = false;
};

const checkoutLink = computed(() => {
  return checkout.value.length > 0 ? "/checkout" : "";
});

watch(
  () => authStore.currentUser,
  () => {
    userName.value = authStore.currentUser?.userName || null;
  },
  { immediate: true }
);

watch(
  () => orderStore.checkOut,
  (newVal) => {
    if (newVal.length > 0) {
      checkout.value = newVal;
    }
  },
  { immediate: true }
);
</script>

<template>
  <div class="bottom-tab-container">
    <div class="bottom-tab-body">
      <RouterLink
        to="/"
        class="bottom-tab-link"
        active-class="bottom-tab-active"
      >
        <FlFilledHome class="text-3xl" />
      </RouterLink>

      <RouterLink
        to="/search"
        class="bottom-tab-link"
        active-class="bottom-tab-active"
      >
        <ChSearch class="text-3xl" />
      </RouterLink>

      <RouterLink
        @click.native="handleOpenCart"
        :to="checkoutLink"
        class="bottom-tab-link bg-transparent w-auto h-auto"
        :active-class="{ 'bottom-tab-active': checkout.length > 0 }"
      >
        <FaCartShopping class="text-3xl" />
      </RouterLink>
      <div class="bottom-tab-link">
        <RouterLink
          :to="`/profile/${userName}`"
          class="bottom-tab-link"
          active-class="bottom-tab-active"
          v-if="userName"
        >
          <BsPersonFill class="text-3xl" />
        </RouterLink>
        <RouterLink
          to="/no-user"
          class="bottom-tab-link"
          active-class="bottom-tab-active"
          v-else
        >
          <BsPersonFill class="text-3xl" />
        </RouterLink>
      </div>
    </div>
  </div>
  <CartView :open="open" @close="handleCloseCart" />
</template>

<style scoped>
.bottom-tab-container {
  width: 100vw;
  position: absolute;
  display: flex;
  justify-content: center;
  align-items: center;
  bottom: 10px;
  z-index: 11;
}
.bottom-tab-body {
  display: flex;
  flex-direction: row;
  width: 300px;
  height: 60px;
  background-color: var(--color-background-blur);
  border-radius: 30px;
  backdrop-filter: blur(10px);
  justify-content: space-evenly;
  align-items: center;
}
/* animate the tab links to scale on hover */
.bottom-tab-link {
  transition: transform 0.2s ease-in-out;
  color: var(--icon-color);
}
.bottom-tab-active {
  color: var(--primary-brand-color);
}
.bottom-tab-link:hover {
  transform: scale(1.3);
  background-color: transparent;
}
</style>
