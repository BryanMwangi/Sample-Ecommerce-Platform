<script setup>
import { onMounted, onUnmounted, ref, watch } from "vue";
import { useRoute } from "vue-router";
import MasonryAction from "@/components/MasonryAction/MasonryAction.vue";
import ItemView from "@/components/ItemView/ItemView.vue";
import PostSkeleton from "@/components/Skeletons/PostSkeleton.vue";
import ItemCategories from "@/components/Categories/ItemCategories.vue";
import { usePostsStore } from "@/stores/posts.js";
import ActivityLoader from "@/components/ui/loader/ActivityLoader.vue";

const postsStore = usePostsStore();
const open = ref(false);
const selected = ref(null);
const loading = ref(true);
const loadingMore = ref(false);
const route = useRoute();
const renderData = ref([]);
const query = ref("");
const lastFetchedPage = ref(0);
const scrollContainer = ref(null);
const querySearch = ref(false);

const handleSelect = (item) => {
  selected.value = item.id;
  open.value = true;
};

const handleClose = () => {
  open.value = false;
};

const dummyData = Array.from({ length: 15 });
const fetchData = async (category) => {
  loading.value = true;
  const posts = await postsStore.fetchPosts(postsStore.setPage, category);
  renderData.value = [...posts];
  lastFetchedPage.value = 1;
  postsStore.setPage = 1;
  loading.value = false;
  return;
};

const searchPosts = async (q) => {
  loading.value = true;
  const posts = await postsStore.searchPost(q);
  renderData.value = posts;
  loading.value = false;
  postsStore.setPage = 1;
  return;
};

// Fetch data on mount
onMounted(() => {
  if (
    route.query ||
    (route.query.category !== undefined && route.query.q !== undefined)
  ) {
    return;
  }
  fetchData();
});

watch(
  () => route.query,
  (newVal) => {
    if (newVal.category) {
      fetchData(newVal.category);
      query.value = newVal.category;
    } else if (newVal.q) {
      searchPosts(newVal.q);
      query.value = "";
    } else {
      fetchData();
      query.value = "";
    }
  },
  { immediate: true }
);

const handleScroll = async (event) => {
  let scrollTop = event.target.scrollTop;
  let maxScrollTop = event.target.scrollHeight - event.target.clientHeight;
  if (
    scrollTop >= maxScrollTop - 200 &&
    postsStore.setPage === lastFetchedPage.value
  ) {
    loadingMore.value = true;
    const morePosts = await postsStore.fetchPosts(
      postsStore.setPage + 1,
      query.value
    );
    let tempArray = [];
    // only add unique posts
    for (const post of morePosts) {
      if (!renderData.value.some((item) => item.id === post.id)) {
        tempArray.push(post);
      }
    }
    renderData.value = [...renderData.value, ...tempArray];
    tempArray = [];
    // small delay before increasing the page number
    setTimeout(() => {
      lastFetchedPage.value++;
    }, 1000);
    setTimeout(() => {
      postsStore.setPage++;
      loadingMore.value = false;
    }, 1500);
  }
};

onUnmounted(() => {
  postsStore.setPage = 1;
});
</script>

<template>
  <main class="main-container" v-on:scroll="handleScroll" ref="scrollContainer">
    <ItemCategories :query="query" />

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

    <div
      class="flex flex-col items-center justify-center mt-10"
      v-if="renderData && renderData.length === 0"
    >
      <h1 class="text-2xl font-bold w-full text-center">No results found</h1>
      <p class="text-center text-muted-foreground text-lg mt-2">
        Please try searching for something else
      </p>
    </div>

    <masonry-wall
      v-else
      :items="renderData"
      :ssr-columns="1"
      :column-width="300"
      :gap="16"
      :scroll-container="scrollContainer"
    >
      <template #default="{ item, index }">
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
    <div v-if="loadingMore" class="w-full flex justify-center items-center">
      <ActivityLoader />
    </div>
    <div class="h-[300px]" />
    <ItemView :open="open" :itemId="selected" @close="handleClose" />
  </main>
</template>

<style scoped>
.main-view-container {
  width: 100%;
  margin-bottom: 60px;
}
.image {
  height: auto;
  width: 240px;
  border-radius: 12px;
}
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
.placeholder-item {
  padding-top: 10px;
  padding-bottom: 30px;
  height: 420px;
  width: 260px;
}
</style>
