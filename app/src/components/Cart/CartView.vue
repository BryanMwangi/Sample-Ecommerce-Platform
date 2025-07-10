<script setup>
import { ref, computed, watch } from "vue";
import { Button } from "@/components/ui/button";
import {
  Sheet,
  SheetContent,
  SheetFooter,
  SheetHeader,
} from "@/components/ui/sheet";
import CartSkeleton from "../Skeletons/CartSkeleton.vue";
import { useOrderStore } from "@/stores/orders";
import { BsTrash3 } from "@kalimahapps/vue-icons";
import {
  NumberField,
  NumberFieldContent,
  NumberFieldDecrement,
  NumberFieldIncrement,
  NumberFieldInput,
} from "@/components/ui/number-field";
import router from "@/router";

const props = defineProps({
  open: Boolean,
});
const emit = defineEmits(["close"]);
const orderStore = useOrderStore();
const cart = orderStore.cart;
const loading = ref(false);

const cartItems = computed(() => {
  try {
    loading.value = true;
    if (cart.length === 0) {
      loading.value = false;
      return [];
    }
    return Object.values(
      cart.reduce((acc, item) => {
        const storeId = item.store.storeId;
        if (!acc[storeId]) {
          acc[storeId] = {
            items: [],
            store: item.store,
          };
        }
        acc[storeId].items.push({ ...item, quantity: 1 });
        loading.value = false;
        return acc;
      }, {})
    );
  } catch (e) {
    loading.value = false;
    console.log(e);
    return [];
  }
});

const addToFinalCart = (items) => {
  orderStore.addToCheckOut(items);
  router.push(`/checkout`);
  emit("close");
};

const removeFromCart = (group) => {
  const itemIndex = cart.findIndex(
    (item) => item.store.storeId === group.store.storeId
  );

  if (itemIndex !== -1) {
    cart.splice(itemIndex, 1); // Remove the item from the cart array
  }
};
</script>

<template>
  <Sheet :open="open" @update:open="$emit('close')">
    <SheetContent
      style="max-width: 491px"
      class="overflow-auto modify-scroll-container"
    >
      <CartSkeleton v-if="loading" />
      <div v-else>
        <SheetHeader class="flex flex-col items-center">
          <h1
            class="text-3xl font-bold w-full text-center mb-4 mt-4 truncate overflow-hidden whitespace-nowrap"
          >
            Checkout
          </h1>
        </SheetHeader>

        <div v-if="cartItems.length === 0">
          <div class="flex flex-col items-center justify-center">
            <h1 class="text-2xl font-bold w-full text-center">
              Your shopping cart is empty
            </h1>
            <span class="text-center text-muted-foreground text-lg mt-2"
              >Add items to your cart to checkout</span
            >
          </div>
        </div>

        <div
          v-else
          class="border-border border rounded-lg p-4 w-full mb-10"
          v-for="(group, index) in cartItems"
          :key="index"
        >
          <div class="flex flex-row items-center gap-2 mb-4 justify-between">
            <img
              :src="group.store.profilePicture"
              alt="profile picture"
              class="h-8 w-8 rounded-full object-cover"
            />
            <h1
              class="text-lg font-bold truncate max-w-[300px] overflow-hidden whitespace-nowrap"
            >
              {{ group.store.name }}
            </h1>
            <Button
              class="bg-transparent text-muted-foreground hover:bg-transparent hover:text-pink-600 rounded-full m-0 p-0"
              @click="removeFromCart(group)"
            >
              <BsTrash3 class="text-lg" />
            </Button>
          </div>

          <div v-for="(item, index) in group.items" :key="index">
            <div class="flex flex-row justify-between">
              <div class="flex flex-row items-center gap-2 mb-7">
                <img
                  :src="item.imageUrl"
                  alt="item image"
                  class="h-[100px] min-w-[90px] rounded-lg object-cover"
                />
                <div class="ml-3">
                  <h1 class="text-md font-bold max-w-[150px] line-clamp-3">
                    {{ item.name }}
                  </h1>
                  <div
                    class="flex flex-row items-center gap-2 text-lg font-bold mt-2"
                  >
                    <p>{{ item.currency }}</p>
                    <p>{{ item.price }}</p>
                  </div>
                </div>
              </div>
              <NumberField
                id="age"
                :default-value="item.quantity"
                :min="1"
                style="max-width: 110px"
              >
                <NumberFieldContent
                  class="flex flex-row items-center gap-2 w-30 min-w-30 h-10"
                >
                  <NumberFieldDecrement />
                  <NumberFieldInput />
                  <NumberFieldIncrement />
                </NumberFieldContent>
              </NumberField>
            </div>
          </div>

          <Button
            class="w-full bg-[rgba(240,110,166,0.45)] text-pink-400 hover:bg-pink-400 hover:text-white"
            @click="addToFinalCart(group.items)"
          >
            <span>Go to checkout</span>
          </Button>
        </div>
      </div>
    </SheetContent>
  </Sheet>
</template>
<style scoped>
.item-image {
  width: 80%;
  height: auto;
  border-radius: 12px;
}
</style>
