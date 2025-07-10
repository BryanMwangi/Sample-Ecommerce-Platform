<script setup>
const props = defineProps({
  image: {
    type: String,
    required: true,
  },
  title: {
    type: String,
    required: true,
  },
  message: {
    type: String,
    required: true,
  },
});
</script>

<template>
  <div
    class="flex items-center space-x-4 px-4 py-3 bg-background border shadow-lg rounded-lg w-[350px]"
  >
    <img :src="image" alt="Cart image" class="w-14 h-14 object-cover rounded" />
    <div class="flex flex-col">
      <span class="text-foreground">{{ title }}</span>
      <span class="text-muted-foreground">{{ message }}</span>
    </div>
  </div>
</template>
