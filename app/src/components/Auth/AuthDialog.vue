<script setup>
import { useAuthStore } from "@/stores/auth";
import { ref } from "vue";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { toast } from "vue-sonner";

const authStore = useAuthStore();
const email = ref("");
const password = ref("");
const name = ref("");
const username = ref("");
const loading = ref(false);

const handleLogin = async () => {
  try {
    loading.value = true;
    if (email.value === "" || password.value === "") {
      toast("Missing fields", {
        description: "Please fill in all fields",
      });
      return;
    }
    await authStore.login(email.value, password.value);
    authStore.closeAuthDialog();
    email.value = "";
    password.value = "";
    name.value = "";
  } catch (error) {
    console.log(error);
  } finally {
    loading.value = false;
  }
};

const handleSignup = async () => {
  try {
    loading.value = true;
    if (
      name.value === "" ||
      email.value === "" ||
      password.value === "" ||
      username.value === ""
    ) {
      toast("Missing fields", {
        description: "Please fill in all fields",
      });
      return;
    }
    await authStore.signup(
      name.value,
      username.value,
      email.value,
      password.value
    );
    authStore.closeAuthDialog();
    email.value = "";
    password.value = "";
    name.value = "";
  } catch (error) {
    console.log(error);
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <Dialog
    :open="authStore.isAuthDialogOpen"
    @update:open="authStore.closeAuthDialog"
  >
    <DialogContent>
      <Tabs :default-value="authStore.authDialogMode" class="w-full mt-10">
        <TabsList class="grid w-full grid-cols-2">
          <TabsTrigger value="login"> Log in </TabsTrigger>
          <TabsTrigger value="signup"> Sign up </TabsTrigger>
        </TabsList>
        <TabsContent value="login">
          <Card class="bg-transparent border-none">
            <CardHeader>
              <CardTitle>Welcome to Yumzies!</CardTitle>
              <CardDescription class="text-md">
                You can login to your account here with your email and password.
              </CardDescription>
            </CardHeader>
            <CardContent class="space-y-2">
              <div class="space-y-1">
                <Label for="name">Email</Label>
                <Input
                  id="email"
                  placeholder="Email"
                  autocomplete="email"
                  v-model="email"
                  required
                />
              </div>
              <div class="space-y-1">
                <Label for="username">Username</Label>
                <Input
                  id="password"
                  placeholder="Password"
                  autocomplete="current-password"
                  type="password"
                  v-model="password"
                  required
                />
              </div>
            </CardContent>
            <CardFooter class="flex flex-col items-start">
              <Button
                class="bg-[rgba(240,110,166,0.45)] hover:bg-pink-400 hover:text-white rounded-lg text-bold w-[100px] text-md text-pink-400"
                @click="handleLogin"
                :disabled="loading"
                :style="{ cursor: loading ? 'not-allowed' : 'pointer' }"
              >
                Login
              </Button>
              <Button
                class="bg-transparent hover:text-pink-600 hover:bg-transparent text-bold w-10 ml-10 mt-5 text-md text-pink-400"
                @click="authStore.openResetPasswordDialog"
              >
                Forgot password?
              </Button>
            </CardFooter>
          </Card>
        </TabsContent>
        <TabsContent value="signup">
          <Card class="bg-transparent border-none">
            <CardHeader>
              <CardTitle>Sign up</CardTitle>
              <CardDescription class="text-md">
                Create an account to and start ordering on Yumzies.
              </CardDescription>
            </CardHeader>
            <CardContent class="space-y-2">
              <div class="space-y-1">
                <Label for="name">Name</Label>
                <Input
                  id="name"
                  type="name"
                  autocomplete="name"
                  placeholder="John Doe"
                  v-model="name"
                  required
                />
              </div>
              <div class="space-y-1">
                <Label for="username">User name</Label>
                <Input
                  id="username"
                  type="username"
                  autocomplete="username"
                  placeholder="johndoe"
                  v-model="username"
                  required
                />
              </div>
              <div class="space-y-1">
                <Label for="email">Email</Label>
                <Input
                  id="email"
                  type="email"
                  autocomplete="email"
                  placeholder="Email"
                  v-model="email"
                  required
                />
              </div>
              <div class="space-y-1">
                <Label for="password">Strong password</Label>
                <Input
                  id="password"
                  type="password"
                  autocomplete="new-password"
                  placeholder="Password"
                  v-model="password"
                  required
                />
              </div>
            </CardContent>
            <CardFooter>
              <Button
                class="bg-[rgba(240,110,166,0.45)] text-pink-400 hover:bg-pink-400 hover:text-white rounded-lg text-bold text-pink-400 w-[100px] text-md"
                @click="handleSignup"
                :disabled="loading"
                :style="{ cursor: loading ? 'not-allowed' : 'pointer' }"
                >Sign up</Button
              >
            </CardFooter>
          </Card>
        </TabsContent>
      </Tabs>
    </DialogContent>
  </Dialog>
</template>
