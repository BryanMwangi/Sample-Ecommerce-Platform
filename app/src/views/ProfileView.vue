<script setup>
import { onMounted, ref, watch } from "vue";
import { useRoute } from "vue-router";
import Profile from "@/components/Profile/Profile.vue";
import Loader from "@/components/ui/loader/Loader.vue";
import { useAuthStore } from "@/stores/auth";
import router from "@/router";

const authStore = useAuthStore();
const route = useRoute();
const userName = ref(null);
const sreen = "profile";
const data = ref(null);
const loading = ref(true);

onMounted(() => {
  loading.value = true;
  fetchUser();
});

const fetchUser = async () => {
  data.value = authStore.currentUser || null;
  loading.value = false;
};

watch(
  () => route.params.userName,
  (newUserName) => {
    userName.value = newUserName;
    fetchUser();
  }
);

watch(
  () => authStore.currentUser,
  (newVal) => {
    if (newVal === null) {
      router.push("/no-user");
    }
  },
  { immediate: true }
);
</script>

<template>
  <div class="main-container">
    <div v-if="loading">
      <Loader />
    </div>
    <Profile :data="data" :screenName="sreen" v-else />
  </div>
</template>

<style scoped></style>
