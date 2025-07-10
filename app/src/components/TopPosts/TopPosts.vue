<script setup>
import { onMounted, ref } from "vue";
import { usePostsStore } from "@/stores/posts";
import MasonryAction from "../MasonryAction/MasonryAction.vue";
import ItemView from "../ItemView/ItemView.vue";
import { Button } from "@/components/ui/button";
import PostSkeleton from "../Skeletons/PostSkeleton.vue";

const topPosts = ref([]);
const postsStore = usePostsStore();
const selected = ref(null);
const open = ref(false);
const loading = ref(true);

const dummyData = Array.from({ length: 12 });

const handleClose = () => {
  open.value = false;
};

const handleSelect = (item) => {
  selected.value = item.id;
  open.value = true;
};

onMounted(async () => {
  try {
    loading.value = true;
    if (postsStore.posts.length === 0) {
      const randomPage = Math.floor(Math.random() * 10);
      const posts = await postsStore.fetchPosts(randomPage);
      postsStore.topPosts = posts.slice(0, 12); // Take only the first 6 posts
      topPosts.value = postsStore.topPosts;
    } else {
      topPosts.value = postsStore.topPosts.slice(0, 12); // Ensure only 6 are shown
    }
    loading.value = false;
  } catch (error) {
    console.log(error);
    topPosts.value = [];
  }
});
</script>
<template>
  <div
    class="w-full mb-4 mt-4 pl-10 flex flex-row items-center justify-between pr-10"
  >
    <h1
      class="text-3xl font-bold text-left truncate overflow-hidden whitespace-nowrap"
    >
      Top Picks
    </h1>
    <RouterLink
      to="/search"
      class="bg-[rgba(240,110,166,0.45)] text-pink-400 hover:bg-pink-400 hover:text-white text-lg p-2 w-[100px] rounded-lg flex items-center justify-center"
      >See more</RouterLink
    >
  </div>
  <masonry-wall
    v-if="loading"
    :items="dummyData"
    :ssr-columns="1"
    :column-width="260"
    :gap="16"
  >
    <template #default="{ item, index }">
      <div :key="index" class="placeholder-item">
        <PostSkeleton class="mb-5" />
      </div>
    </template>
  </masonry-wall>

  <masonry-wall
    v-else
    :items="topPosts"
    :ssr-columns="1"
    :column-width="260"
    :gap="16"
    class="mb-10 px-10"
  >
    <template #default="{ item }">
      <div class="item">
        <img
          :src="item.imageUrl"
          alt=""
          class="image"
          @click="handleSelect(item)"
        />
        <MasonryAction
          :title="item.name"
          :price="item.price"
          :currency="item.currency"
          :profilePicture="item.store.profilePicture"
          @select="handleSelect(item)"
        />
      </div>
    </template>
  </masonry-wall>

  <ItemView :open="open" :itemId="selected" @close="handleClose" />
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
.item:hover {
  background-color: rgba(240, 110, 166, 0.45);
  cursor: pointer;
}
.image {
  height: auto;
  width: 240px;
  border-radius: 12px;
}
</style>
