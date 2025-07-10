<script setup>
import { usePostsStore } from "@/stores/posts";
import { onMounted, ref } from "vue";
const postsStore = usePostsStore();
const stores = ref([]);

onMounted(async () => {
  if (postsStore.stores.length === 0) {
    await postsStore.fetchAllStores();
    stores.value = postsStore.stores;
  } else {
    stores.value = postsStore.stores;
  }
});
</script>
<template>
  <h1
    class="text-3xl font-bold w-full text-left mb-4 mt-4 truncate overflow-hidden whitespace-nowrap pl-10"
  >
    Stores
  </h1>
  <div>
    <masonry-wall
      :items="stores"
      :ssr-columns="1"
      :column-width="260"
      :gap="16"
      class="mb-10 px-10"
    >
      <template #default="{ item }">
        <div class="flex flex-col items-center justify-center">
          <RouterLink :to="`/store/${item.id}`" class="a-link-normal">
            <img
              :src="item.profilePicture"
              alt=""
              class="h-[150px] w-[150px] rounded-full object-cover"
            />
          </RouterLink>

          <p class="text-lg text-center font-semibold mt-2">
            {{ item.name }}
          </p>
        </div>
      </template>
    </masonry-wall>
  </div>
</template>
<style scoped></style>
