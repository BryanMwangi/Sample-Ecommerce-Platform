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
import {
  PinInput,
  PinInputGroup,
  PinInputInput,
  PinInputSeparator,
} from "@/components/ui/pin-input";
import { toast } from "vue-sonner";

const authStore = useAuthStore();
const email = ref("");
const code = ref([]);
const loading = ref(false);
const currentDialog = ref("email");

const handleSendResetPasswordEmail = async () => {
  try {
    loading.value = true;
    if (email.value === "") {
      toast("Missing fields", {
        description: "Please fill in all fields",
      });
      return;
    }
    await authStore.sendResetPasswordEmail(email.value);
    currentDialog.value = "code";
    toast("Email sent", {
      description: "Please check your email for the reset password code",
    });
  } catch (error) {
    console.log(error);
  } finally {
    loading.value = false;
  }
};

const handleCheckCode = async () => {
  try {
    loading.value = true;
    // we first flatten the code to a string
    if (code.value.length !== 6) {
      toast("Invalid code", {
        description: "Please enter a valid code",
      });
      return;
    }
    const flattenedCode = code.value.join("");
    await authStore.checkCode(flattenedCode);
    toast("Code accepted", {
      description: "Enter your new password",
    });
  } catch (error) {
    console.log(error);
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <Dialog
    :open="authStore.isResetPasswordDialogOpen"
    @update:open="authStore.closeResetPasswordDialog"
  >
    <DialogContent>
      <Tabs :default-value="currentDialog" class="w-full mt-10">
        <TabsList class="grid w-full grid-cols-2">
          <TabsTrigger value="email"> Email </TabsTrigger>
          <TabsTrigger value="code"> Code </TabsTrigger>
        </TabsList>
        <TabsContent value="email">
          <Card class="bg-transparent border-none">
            <CardHeader>
              <CardTitle>Enter your email</CardTitle>
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
            </CardContent>
            <CardFooter>
              <Button
                class="bg-[rgba(240,110,166,0.45)] hover:bg-pink-400 hover:text-white rounded-lg text-bold w-[100px] text-md text-pink-400"
                :disabled="loading"
                :style="{ cursor: loading ? 'not-allowed' : 'pointer' }"
                @click="handleSendResetPasswordEmail"
              >
                Send code
              </Button>
            </CardFooter>
          </Card>
        </TabsContent>
        <TabsContent value="code">
          <Card
            class="bg-transparent border-none"
            v-if="!authStore.codeAccepted"
          >
            <CardHeader>
              <CardTitle>Enter the code</CardTitle>
              <CardDescription class="text-md">
                Enter the code we sent to your email.
              </CardDescription>
            </CardHeader>
            <CardContent class="space-y-2">
              <PinInput id="pin-input" v-model="code" placeholder="○">
                <PinInputGroup class="gap-1">
                  <template v-for="(id, index) in 6" :key="id">
                    <PinInputInput
                      class="rounded-md border bg-background"
                      :index="index"
                    />
                    <template v-if="index !== 5">
                      <PinInputSeparator />
                    </template>
                  </template>
                </PinInputGroup>
              </PinInput>
            </CardContent>
            <CardFooter>
              <Button
                class="bg-[rgba(240,110,166,0.45)] text-pink-400 hover:bg-pink-400 hover:text-white rounded-lg text-bold text-pink-400 w-[100px] text-md"
                :disabled="loading"
                :style="{ cursor: loading ? 'not-allowed' : 'pointer' }"
                @click="handleCheckCode"
                >Submit</Button
              >
            </CardFooter>
          </Card>

          <Card class="bg-transparent border-none" v-else>
            <CardHeader>
              <CardTitle>Enter your new password</CardTitle>
            </CardHeader>
            <CardContent class="space-y-2">
              <div class="space-y-1">
                <Label for="password">New password</Label>
                <Input
                  id="password"
                  type="password"
                  autocomplete="new-password"
                  placeholder="Password"
                  v-model="password"
                  required
                />
              </div>
              <div class="space-y-1">
                <Label for="password">Confirm password</Label>
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
                class="bg-[rgba(240,110,166,0.45)] hover:bg-pink-400 hover:text-white rounded-lg text-bold w-[100px] text-md text-pink-400"
                :disabled="loading"
                :style="{ cursor: loading ? 'not-allowed' : 'pointer' }"
              >
                Reset Password
              </Button>
            </CardFooter>
          </Card>
        </TabsContent>
      </Tabs>
    </DialogContent>
  </Dialog>
</template>
