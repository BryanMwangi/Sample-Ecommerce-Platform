<script setup>
import { onMounted, ref, watch } from "vue";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import {
  Card,
  CardContent,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { useOrderStore } from "@/stores/orders";
import { toast } from "vue-sonner";
import { McHome3Fill } from "@kalimahapps/vue-icons";
const orderStore = useOrderStore();
const street = ref("");
const city = ref("");
const zip = ref("");
const country = ref("");
const loading = ref(false);
const savedAddresses = ref([]);

watch(
  () => orderStore.addresses,
  (newVal) => {
    savedAddresses.value = newVal;
  },
  { immediate: true }
);

const addAddress = async () => {
  if (
    street.value === "" ||
    city.value === "" ||
    zip.value === "" ||
    country.value === ""
  ) {
    toast("Missing fields", {
      description: "Please fill in all fields",
    });
    return;
  }
  await orderStore.addNewAddress(
    street.value,
    city.value,
    zip.value,
    country.value
  );
  orderStore.closeAddressDialog();
  street.value = "";
  city.value = "";
  zip.value = "";
  country.value = "";

  toast("Address added", {
    description: "Address added successfully",
  });
};

onMounted(async () => {
  await orderStore.fetchAllAddresses();
});
</script>

<template>
  <Dialog
    :open="orderStore.addressDialogOpen"
    @update:open="orderStore.closeAddressDialog"
  >
    <DialogContent>
      <Tabs default-value="addresses" class="w-full mt-10">
        <TabsList class="grid w-full grid-cols-2">
          <TabsTrigger value="addresses"> My addresses</TabsTrigger>
          <TabsTrigger value="addAddress"> Add new address </TabsTrigger>
        </TabsList>
        <TabsContent value="addresses">
          <Card class="bg-transparent border-none">
            <CardHeader>
              <CardTitle>My addresses</CardTitle>
            </CardHeader>
            <CardContent class="space-y-2">
              <div
                class="flex flex-col w-full gap-5 justify-center items-center"
              >
                <div class="delivery-address-container w-full">
                  <div v-if="savedAddresses.length === 0">
                    <h1 class="text-lg font-bold text-left w-full">
                      No saved addresses found
                    </h1>
                    <span class="text-left text-muted-foreground text-lg mt-2"
                      >Add a new address to your account</span
                    >
                  </div>
                  <div
                    v-else
                    class="border-border border rounded-lg p-4 w-full mb-4"
                    v-for="(address, index) in savedAddresses"
                    :key="index"
                  >
                    <div class="flex flex-row items-center gap-2 mb-1">
                      <McHome3Fill class="text-pink-400 text-2xl" />
                      <div class="flex flex-col ml-5">
                        <h1
                          class="text-lg font-semibold truncate max-w-[300px] overflow-hidden whitespace-nowrap"
                        >
                          {{ address.street }}
                        </h1>
                        <h1
                          class="text-lg font-semibold truncate max-w-[300px] overflow-hidden whitespace-nowrap"
                        >
                          {{ address.city }}
                        </h1>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
        <TabsContent value="addAddress">
          <Card class="bg-transparent border-none">
            <CardHeader>
              <CardTitle>Add new address</CardTitle>
            </CardHeader>
            <CardContent class="space-y-2">
              <div class="space-y-1">
                <Label for="street">Street</Label>
                <Input
                  id="street"
                  type="street"
                  autocomplete="street-address"
                  placeholder="123 Main St"
                  v-model="street"
                  required
                />
              </div>
              <div class="space-y-1">
                <Label for="city">City</Label>
                <Input
                  id="city"
                  type="city"
                  autocomplete="address-level2"
                  placeholder="Budapest"
                  v-model="city"
                  required
                />
              </div>

              <div class="space-y-1">
                <Label for="zip">Zip</Label>
                <Input
                  id="zip"
                  type="zip"
                  autocomplete="postal-code"
                  placeholder="zip"
                  v-model="zip"
                  required
                />
              </div>
              <div class="space-y-1">
                <Label for="country">Country</Label>
                <Input
                  id="country"
                  type="country"
                  autocomplete="country"
                  placeholder="country"
                  v-model="country"
                  required
                />
              </div>
            </CardContent>
            <CardFooter>
              <Button
                class="bg-[rgba(240,110,166,0.45)] text-pink-400 hover:bg-pink-400 hover:text-white rounded-lg text-bold text-pink-400 w-[100px] text-md"
                :disabled="loading"
                @click="addAddress"
                :style="{ cursor: loading ? 'not-allowed' : 'pointer' }"
                >Continue</Button
              >
            </CardFooter>
          </Card>
        </TabsContent>
      </Tabs>
    </DialogContent>
  </Dialog>
</template>
