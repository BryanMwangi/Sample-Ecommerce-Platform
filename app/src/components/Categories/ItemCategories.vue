<script setup>
import { usePostsStore } from "@/stores/posts";
import { onMounted, ref } from "vue";

const postsStore = usePostsStore();
const categories = ref([]);
const props = defineProps({
  query: {
    type: String,
    required: true,
  },
});

onMounted(async () => {
  await postsStore.fetchCategories();
  categories.value = postsStore.categories;
});
</script>
<template>
  <div
    class="modify-no-scroll-container category-container flex flex-row gap-4 w-full items-center pl-4 pr-4"
  >
    <RouterLink
      v-for="category in categories"
      :key="category"
      :to="`/search?category=${category.originalName}`"
      class="hover:bg-transparent hover:text-pink-600 rounded-full px-7 h-10 flex items-center justify-center"
      :class="{
        'bg-gray-200 text-black': query !== category.originalName,
        'bg-transparent text-pink-600': query === category.originalName,
      }"
    >
      <p class="text-md text-center">
        {{ category.name }}
      </p>
    </RouterLink>
  </div>
</template>
<style scoped>
.category-container {
  height: 70px;
  overflow-y: hidden;
  overflow-x: scroll;
}
</style>
