<script setup>
import { Button } from "@/components/ui/button";
import AnimatedMasonry from "@/components/Animations/AnimatedMasonry.vue";
import { useAuthStore } from "@/stores/auth";
import { watch } from "vue";
import router from "@/router";

const authStore = useAuthStore();

watch(
  () => authStore.currentUser,
  (newVal) => {
    if (newVal !== null) {
      router.push(`/profile/${newVal.userName}`);
    }
  },
  { immediate: true }
);
</script>

<template>
  <main>
    <div class="no-user-body">
      <h1 class="text-5xl font-bold capitalize">Taste Just for You</h1>
      <p class="text-xl font-medium my-5">
        Find Dishes You Didn't Know You Were Craving!
      </p>
      <Button
        class="bg-[rgba(240,110,166,0.45)] text-pink-400 hover:bg-pink-400 hover:text-white text-lg p-5"
        @click="authStore.openAuthDialog('login')"
        >Explore Now</Button
      >
    </div>
    <AnimatedMasonry />
  </main>
</template>

<style>
.item {
  padding-right: 10px;
  padding-left: 10px;
  padding-top: 10px;
  padding-bottom: 30px;
  height: max-content;
  width: 260px;
  border-radius: 12px;
  transition: background-color 0.3s ease;
}

.no-user-body {
  position: absolute;
  height: 100vh;
  width: 100vw;
  z-index: 1;
  background-color: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(10px);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
/* animate the blur */
.no-user-body {
  animation: blur-bg 5s ease-in-out;
}

@keyframes blur-bg {
  0% {
    backdrop-filter: blur(0px);
  }
  100% {
    backdrop-filter: blur(10px);
  }
}
@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}
</style>
