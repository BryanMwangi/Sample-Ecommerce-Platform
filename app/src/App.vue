<script setup>
import { RouterView } from "vue-router";
import MainNav from "./components/MainNav/MainNav.vue";
import BottomNav from "./components/BottomNav/BottomNav.vue";
import AuthDialog from "./components/Auth/AuthDialog.vue";
import { Toaster } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { useAuthStore } from "@/stores/auth";
import { onMounted } from "vue";
import AddressDialog from "./components/Addresses/AddressDialog.vue";
import ResetPassword from "./components/ResetPassword/ResetPassword.vue";

const authStore = useAuthStore();

onMounted(() => {
  authStore.fetchUser();
});
</script>

<template>
  <TooltipProvider>
    <AuthDialog />
    <AddressDialog />
    <ResetPassword />
    <Toaster position="bottom-left" />
    <header class="nav-container">
      <MainNav />
    </header>

    <div>
      <RouterView />
    </div>
    <BottomNav />
  </TooltipProvider>
</template>

<style scoped>
.nav-container {
  border-bottom: solid 1px var(--color-border);
  position: absolute;
  top: 0;
  height: 70px;
  background-color: var(--color-background-blur);
  backdrop-filter: blur(20px);
  z-index: 9;
}
.main-container {
  padding-top: 70px;
  overflow: auto;
  width: 100vw;
  height: 100vh;

  scrollbar-width: thin;
  scrollbar-color: #989898 transparent;
}

.main-container::-webkit-scrollbar {
  width: 12px;
}

.main-container::-webkit-scrollbar-track {
  background: #989898;
}

.main-container::-webkit-scrollbar-thumb {
  background-color: transparent;
  border-radius: 10px;
  border: 3px solid #989898;
}

.main-container::-webkit-scrollbar-thumb:hover {
  background-color: #989898;
}
</style>

<!-- <nav>
  <RouterLink to="/">Home</RouterLink>
  <RouterLink to="/about">About</RouterLink>
</nav> -->
