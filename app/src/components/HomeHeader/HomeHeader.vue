<script setup>
import { onMounted, ref } from "vue";
import { heroImages } from "./data.js";
import { RouterLink } from "vue-router";

const images = ref(heroImages);
const currentImage = ref(0);
const show = ref(true);

const cycleImages = () => {
  show.value = false; // Trigger fade-out

  setTimeout(() => {
    currentImage.value = (currentImage.value + 1) % images.value.length; // Change image after fade-out
    show.value = true; // Trigger fade-in
  }, 2000); // Time for fade-out
 
  setTimeout(cycleImages, 10000);// Loop every 10 seconds
};

onMounted(() => {
  cycleImages();
});
</script>
<template>
  <div class="hero-container">
    <img
      :key="currentImage"
      :src="images[currentImage]"
      alt="hero image"
      class="hero-image"
      :class="{ 'fade-in': show, 'fade-out': !show }"
    />

    <div class="hero-text-container">
      <div class="hero-text">
        <img src="../../assets/Yumzies.svg" alt="logo" class="logo-header" />
        <p class="text-3xl font-medium my-5">
          Welcome to Yumzies, you imagine it we deliver
        </p>

        <RouterLink
          to="/search"
          class="bg-[rgba(240,110,166,0.45)] text-pink-400 hover:bg-pink-400 hover:text-white text-lg p-2 w-[120px] rounded-lg"
        >
          Explore Now
        </RouterLink>
      </div>
    </div>
  </div>
</template>

<style>
.hero-container {
  width: 100%;
  height: 600px;
  display: flex;
  position: relative;
  overflow: hidden;
}
.hero-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  position: static;
}
.hero-text-container {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 300px;
  background: linear-gradient(to bottom, transparent, var(--color-background));
}

.hero-text {
  width: 100%;
  height: 100%;
  text-align: center;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.logo-header {
  height: 90px;
  max-width: 100%;
  object-fit: contain;
}
.fade-in {
  animation: fadeIn 2s ease-in-out;
}

.fade-out {
  animation: fadeOut 3s ease-in-out;
}

@keyframes fadeIn {
  0% {
    opacity: 0;
  }
  100% {
    opacity: 1;
  }
}
@keyframes fadeOut {
  0% {
    opacity: 1;
  }
  100% {
    opacity: 0;
  }
}
</style>
