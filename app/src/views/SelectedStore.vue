<script setup>
import { onMounted, ref, watch } from "vue";
import { useRoute } from "vue-router";
import { stores } from "@/assets/stores";
import Profile from "@/components/Profile/Profile.vue";
import Loader from "@/components/ui/loader/Loader.vue";
import { usePostsStore } from "@/stores/posts";
//here we check the store id from the url
//and for the sake of the demo we will get the store from stores.js
//and render the store data
const route = useRoute();
const storeId = ref(route.params.storeId);
const postsStore = usePostsStore();
const sreen = "store";
const store = ref(null);
const loading = ref(true);

onMounted(() => {
  loading.value = true;
  findStore(); // Try to find the store after mounting
});

const findStore = async () => {
  try {
    const storeIdAsNumber = parseInt(storeId.value, 10);
    if (storeIdAsNumber === null || storeIdAsNumber === undefined) {
      return;
    }
    const matchedStore = await postsStore.fetchStoreById(storeIdAsNumber);
    store.value = matchedStore;
    loading.value = false;
  } catch (error) {
    console.log(error);
  }
};

watch(
  () => route.params.storeId,
  (newStoreId) => {
    storeId.value = newStoreId;
    findStore(newStoreId);
  }
);
</script>

<template>
  <div class="main-container">
    <div v-if="loading">
      <Loader />
    </div>
    <Profile :data="store" :screenName="sreen" v-else />
  </div>
</template>

<style scoped></style>
