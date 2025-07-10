<script setup>
import { RouterLink } from "vue-router";
import { Bell } from "lucide-vue-next";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import Menu from "./components/Menu.vue";
import { useAuthStore } from "@/stores/auth";
import SearchBar from "./components/SearchBar.vue";

const authStore = useAuthStore();
</script>

<template>
  <div class="main-nav">
    <RouterLink to="/" class="logo-container">
      <img src="../../assets/appIcon.svg" alt="logo" class="logo" />
      <img src="../../assets/Yumzies.svg" alt="logo" class="logo-title" />
    </RouterLink>

    <SearchBar />

    <div class="secondary-actions">
      <div class="flex flex-row gap-4" v-if="authStore.currentUser === null">
        <Button
          class="bg-pink-500 rounded-full text-bold text-black"
          @click="authStore.openAuthDialog('login')"
        >
          Login
        </Button>
        <Button
          class="rounded-full text-bold bg-gray-200 text-black"
          @click="authStore.openAuthDialog('signup')"
        >
          Signup
        </Button>
      </div>
      <div class="flex flex-row" v-else>
        <div>
          <Button
            class="bg-transparent text-pink-500 hover:bg-transparent hover:text-pink-600 rounded-full"
          >
            <Bell />
          </Button>
        </div>

        <div class="flex items-center gap-2">
          <Avatar>
            <AvatarImage
              :src="authStore.currentUser.profilePicture"
              alt="@radix-vue"
            />
            <AvatarFallback>CN</AvatarFallback>
          </Avatar>
          <Menu />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.main-nav {
  display: grid;
  grid-template-columns: 1fr 3fr 1fr;
  width: 100vw;
  align-items: start;
  padding-top: 15px;
}

.logo-container {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  max-height: 40px;
}
.logo-container:hover {
  background-color: transparent;
}
.logo {
  max-height: 45px;
  max-width: 45px;
  object-fit: contain;
}
@font-face {
  font-family: "Pacifico";
  src: url(../../assets/Fonts/Pacifico-Regular.ttf);
}

.logo-title {
  max-height: 40px;
  margin-left: 20px;
}
.secondary-actions {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  gap: 20px;
}
.search-container {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  position: absolute;
  width: 100vw;
  padding-top: 20px;
}
.search-box {
  background-color: var(--search-bg);
}
</style>
