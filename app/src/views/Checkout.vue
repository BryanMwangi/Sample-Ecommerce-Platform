<script setup>
import router from "@/router";
import { useOrderStore } from "@/stores/orders";
import { onMounted, ref, watch } from "vue";
import { Button } from "@/components/ui/button";
import { McHome3Fill } from "@kalimahapps/vue-icons";
import { toast } from "vue-sonner";

const ordersStore = useOrderStore();
const savedAddresses = ref([]);
watch(
  () => ordersStore.checkOut,
  (newVal) => {
    if (newVal.length === 0) {
      router.push(`/search`);
    }
  },
  { immediate: true }
);

watch(
  () => ordersStore.addresses,
  (newVal) => {
    savedAddresses.value = newVal;
  },
  { immediate: true }
);

onMounted(async () => {
  await ordersStore.fetchAllAddresses();
});

const createOrder = async () => {
  try {
    if (ordersStore.selectedAddressId === null) {
      toast("Missing address", {
        description: "Please select an address",
      });
      return;
    }
    await ordersStore.CreateOrder({
      storeId: ordersStore.cart[0].store.id,
      addressId: ordersStore.selectedAddressId,
      itemIds: ordersStore.cart.map((item) => item.id),
    });
    router.push(`/search`);
    toast("Order created", {
      description: "Order created successfully",
    });
  } catch (error) {
    console.log(error);
  }
};
</script>
<template>
  <div class="main-container">
    <div class="checkout-hero-container">
      <img
        src="https://images.unsplash.com/photo-1543191879-742cb35a3a4e?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
        alt="hero image"
        class="checkout-hero-image"
      />

      <div class="checkout-hero-text-container">
        <div class="checkout-hero-text">
          <h1 class="text-4xl font-bold capitalize w-full text-center">
            Checkout
          </h1>
        </div>
      </div>
    </div>
    <div
      class="flex flex-col items-center justify-center"
      v-if="ordersStore.checkOut.length === 0"
    >
      <h1 class="text-2xl font-bold w-full text-center">
        Your shopping cart is empty
      </h1>
      <span class="text-center text-muted-foreground text-lg mt-2"
        >Add items to your cart to checkout</span
      >
    </div>

    <div class="flex flex-col w-full gap-5 justify-center items-center" v-else>
      <h1 class="text-2xl font-bold w-full text-left max-w-[600px]">
        Delivery Address
      </h1>
      <div class="delivery-address-container">
        <div v-if="savedAddresses.length === 0">
          <h1 class="text-lg font-bold text-left">No saved addresses found</h1>
          <span class="text-left text-muted-foreground text-lg mt-2"
            >Add a new address to your account</span
          >
        </div>
        <div v-else v-for="(address, index) in savedAddresses" :key="index">
          <div
            class="flex flex-row items-center gap-2 cursor-pointer border-border border rounded-lg w-full mb-4 p-4"
            @click="ordersStore.selectAddress(address.id)"
            :class="{
              'selected-address-container':
                ordersStore.selectedAddressId === address.id,
            }"
          >
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

      <div class="flex flex-col max-w-[600px] w-full gap-5">
        <h1 class="text-2xl font-bold w-full text-left">Selected Items</h1>
        <div
          v-for="item in ordersStore.checkOut"
          :key="item.id"
          class="flex flex-col"
        >
          <div class="flex flex-row gap-2 mb-7 w-full">
            <img
              :src="item.imageUrl"
              alt="item image"
              class="h-[100px] w-[100px] rounded-lg object-cover"
            />
            <div class="flex flex-col ml-10">
              <h1 class="text-lg font-bold text-left">
                {{ item.name }}
              </h1>
              <div
                class="flex flex-row items-center gap-2 text-lg font-bold mt-2"
              >
                <h1 class="text-lg font-bold text-left">
                  {{ item.currency }}
                </h1>
                <h1 class="text-lg font-bold text-left">
                  {{ item.price }}
                </h1>
              </div>
            </div>
          </div>
        </div>
      </div>
      <Button
        class="bg-[rgba(240,110,166,0.45)] text-pink-400 hover:bg-pink-400 hover:text-white text-lg p-8 w-full max-w-[600px] rounded-lg"
        @click="createOrder"
      >
        Purchase Now
      </Button>

      <div class="h-[300px]" />
    </div>
  </div>
</template>
<style scoped>
.checkout-hero-container {
  width: 100%;
  height: 350px;
  display: flex;
  position: relative;
  overflow: hidden;
}
.checkout-hero-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  position: static;
}
.checkout-hero-text-container {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 300px;
  background: linear-gradient(to bottom, transparent, var(--color-background));
}

.checkout-hero-text {
  width: 100%;
  height: 100%;
  text-align: center;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.delivery-address-container {
  max-width: 600px;
  border: solid 2px var(--color-border);
  text-align: left;
  border-radius: 12px;
  padding: 20px;
  width: 100%;
}
.selected-address-container {
  background-color: var(--secondary-brand-color);
}
</style>
