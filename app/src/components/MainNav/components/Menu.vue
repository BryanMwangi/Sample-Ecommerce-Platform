<script setup>
import {
  Menubar,
  MenubarContent,
  MenubarItem,
  MenubarMenu,
  MenubarRadioGroup,
  MenubarRadioItem,
  MenubarSeparator,
  MenubarTrigger,
} from "@/components/ui/menubar";
import { ChevronDown } from "lucide-vue-next";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { useAuthStore } from "@/stores/auth";
import { useOrderStore } from "@/stores/orders";

const authStore = useAuthStore();
const orderStore = useOrderStore();
const toggleAddressDialog = () => {
  orderStore.addressDialogOpen = true;
};
</script>

<template>
  <Menubar class="border-0 bg-transparent :active:bg-transparent">
    <MenubarMenu>
      <MenubarTrigger
        ><ChevronDown class="size-6 text-muted-foreground" />
      </MenubarTrigger>
      <MenubarContent class="mt-3 mr-3 z-10">
        <MenubarRadioGroup value="benoit">
          <MenubarRadioItem value="John Doe" class="flex items-center gap-2">
            <Avatar class="w-8 h-8">
              <AvatarImage
                :src="authStore.currentUser.profilePicture"
                alt="profile picture"
              />
              <AvatarFallback>CN</AvatarFallback>
            </Avatar>
            {{ authStore.currentUser.displayName }}
          </MenubarRadioItem>
          <MenubarRadioItem value="myAccount"> My Account </MenubarRadioItem>
          <MenubarRadioItem
            value="settings"
            @select="authStore.openResetPasswordDialog"
          >
            Reset Password
          </MenubarRadioItem>
          <MenubarRadioItem value="addresses" @select="toggleAddressDialog">
            Addresses
          </MenubarRadioItem>
          <MenubarRadioItem value="help"> Help Center </MenubarRadioItem>
          <MenubarRadioItem value="terms"> Terms of Service </MenubarRadioItem>
          <MenubarRadioItem value="privacy"> Privacy Policy </MenubarRadioItem>
        </MenubarRadioGroup>

        <MenubarSeparator />
        <MenubarItem inset class="text-red-600" @click="authStore.logout">
          Log out
        </MenubarItem>
      </MenubarContent>
    </MenubarMenu>
  </Menubar>
</template>

<style scoped></style>
