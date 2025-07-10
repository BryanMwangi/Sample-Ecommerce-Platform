<script setup>
import { ref, render, watch } from "vue";
import { Button } from "@/components/ui/button";
import StoreTabs from "./components/StoreTabs.vue";
import UserTabs from "./components/UserTabs.vue";
import { usePostsStore } from "@/stores/posts";

const props = defineProps({
  screenName: {
    type: String,
    required: true,
  },
  data: Object,
});
const postsStore = usePostsStore();
const renderData = ref(null);
const workingHours = ref(null);

const fetchStoreHours = async () => {
  if (props.screenName === "profile") {
    return;
  }
  const hours = await postsStore.fetchStoreHours(renderData.value.id);
  if (hours.length === 0) {
    workingHours.value = null;
    return;
  }
  workingHours.value = hours[0];
};

const formatTime = (time) => {
  if (time === null || time === undefined) {
    return "";
  }
  return time.slice(0, 5);
};

const checkIfOpen = (time) => {
  try {
    if (!time) {
      return false;
    }

    const currentTime = new Date();
    const [hours, minutes] = time.split(":");

    const openingTime = new Date();
    openingTime.setHours(hours, minutes, 0, 0);

    return currentTime > openingTime;
  } catch (error) {
    console.log(error);
    return false;
  }
};

watch(
  () => props.data,
  (newVal) => {
    renderData.value = newVal;
    fetchStoreHours();
  },
  { immediate: true }
);
</script>

<template>
  <img
    src="https://images.unsplash.com/photo-1514933651103-005eec06c04b?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    alt="background image"
    class="h-52 w-full object-cover"
  />
  <div class="flex flex-row items-center justify-center gap-32">
    <div class="flex flex-col items-center justify-center">
      <span class="minor-title-bold">100</span>
      <span class="minor-title text-muted-foreground">Orders</span>
    </div>
    <div class="flex flex-col items-center justify-center">
      <img
        :src="renderData.profilePicture"
        alt="profile picture"
        class="h-24 w-24 rounded-full object-cover mt-[-20%]"
      />
      <h1 class="minor-title-bold">
        {{ renderData.name || renderData.userName }}
      </h1>
    </div>
    <div class="flex flex-col items-center justify-center">
      <span class="minor-title-bold">50</span>
      <span class="minor-title text-muted-foreground">Reviews</span>
    </div>
  </div>

  <div
    class="flex flex-col items-center justify-center mt-3"
    v-if="screenName !== 'profile'"
  >
    <span class="minor-title text-muted-foreground">
      {{ checkIfOpen(workingHours?.opening) ? "Open" : "Closed" }}
    </span>
    <span class="minor-title text-muted-foreground"
      >Working hours: {{ formatTime(workingHours?.opening) }} -
      {{ formatTime(workingHours?.closing) }}</span
    >
  </div>

  <UserTabs
    :userName="renderData.userName"
    :screenName="screenName"
    v-if="screenName == 'profile'"
  />
  <StoreTabs :storeId="renderData.id" :screenName="screenName" v-else />
</template>

<style scoped>
.minor-title-bold {
  font-size: 1.5rem;
  font-weight: bold;
}
.minor-title {
  font-size: 1rem;
}
</style>
