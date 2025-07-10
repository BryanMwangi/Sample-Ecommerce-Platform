<script setup>
import { defineProps, computed } from "vue";

import { BsStarFill, BsStarHalf, BsStar } from "@kalimahapps/vue-icons";

const props = defineProps({
  rating: {
    type: Number,
    default: 0,
  },
});

const stars = computed(() => {
  const rating = Math.min(Math.max(props.rating, 0), 5);
  const fullStars = Math.floor(rating);
  const halfStar = rating % 1 >= 0.5 ? 1 : 0;
  const emptyStars = Math.max(5 - fullStars - halfStar, 0);

  return {
    fullStars,
    halfStar,
    emptyStars,
  };
});
</script>

<template>
  <div class="flex flex-row items-center gap-1">
    <BsStarFill
      v-for="index in stars.fullStars"
      :key="'full-' + index"
      class="text-pink-600"
    />

    <BsStarHalf v-if="stars.halfStar" class="text-pink-600" />

    <BsStar
      v-for="index in stars.emptyStars"
      :key="'empty-' + index"
      class="text-gray-400"
    />
  </div>
</template>
