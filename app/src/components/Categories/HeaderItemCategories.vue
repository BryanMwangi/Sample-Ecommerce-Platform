<script setup>
import { usePostsStore } from "@/stores/posts";
import { onMounted, ref } from "vue";
import { categoriesImages } from "./data";

const postsStore = usePostsStore();
const categories = ref([]);
const images = ref(categoriesImages);

onMounted(async () => {
  if (postsStore.categories.length === 0) {
    await postsStore.fetchCategories();
    categories.value = postsStore.categories;
  } else {
    categories.value = postsStore.categories;
  }
});
</script>
<template>
  <h1
    class="text-3xl font-bold w-full text-left mb-4 mt-4 truncate overflow-hidden whitespace-nowrap pl-10"
  >
    Categories
  </h1>
  <div
    class="modify-no-scroll-container category-container flex flex-row gap-4 w-full items-center pl-10 pr-4"
  >
    <RouterLink
      v-for="category in categories"
      :key="category"
      :to="`/search?category=${category.originalName}`"
      class="a-link-normal"
    >
      <img
        :src="images[category.name]"
        alt="category image"
        class="h-[200px] w-[200px] rounded-lg object-cover"
      />
      <p class="text-lg text-center font-semibold text-foreground mt-2">
        {{ category.name }}
      </p>
    </RouterLink>
  </div>
</template>
<style scoped>
.category-container {
  height: auto;
  overflow-y: hidden;
  overflow-x: scroll;
}
</style>
