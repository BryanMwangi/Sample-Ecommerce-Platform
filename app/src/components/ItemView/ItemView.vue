<script setup>
import { watch, ref, markRaw, defineComponent, h } from "vue";
import { Button } from "@/components/ui/button";
import {
  Sheet,
  SheetContent,
  SheetDescription,
  SheetTitle,
} from "@/components/ui/sheet";
import { AnOutlinedHeart, ReSendPlaneFill } from "@kalimahapps/vue-icons";
import PostSkeleton from "../Skeletons/PostSkeleton.vue";
import Ratings from "./components/Ratings.vue";
import { toast } from "vue-sonner";
import CustomToast from "./components/CustomToast.vue";
import { useOrderStore } from "@/stores/orders";
import { usePostsStore } from "@/stores/posts";

const orderStore = useOrderStore();
const postsStore = usePostsStore();
const props = defineProps({
  open: Boolean,
  itemId: Number,
});

const currentItem = ref(props.item);
const loading = ref(true);
const emit = defineEmits(["close"]);

const fetchItem = async (itemId) => {
  try {
    if (itemId === null || itemId === undefined) {
      currentItem.value = null;
      return;
    }
    loading.value = true;
    const item = await postsStore.fetchPostById(itemId);
    if (item != null) {
      currentItem.value = item;
    }
  } catch (error) {
    currentItem.value = null;
    console.log(error);
  } finally {
    loading.value = false;
  }
};

const addToCart = () => {
  const image = currentItem.value.imageUrl;
  const message = "Navigate to your cart to check out";
  const title = "Item added to cart";
  orderStore.addToCart(currentItem.value);
  toast.custom(
    markRaw(
      defineComponent({
        render() {
          return h(CustomToast, { image, title, message });
        },
      })
    )
  );
};

watch(
  () => props.itemId,
  (newVal) => {
    fetchItem(newVal);
  },
  { immediate: true }
);
</script>

<template>
  <Sheet :open="open" @update:open="$emit('close')">
    <SheetContent
      style="max-width: 491px"
      class="overflow-auto modify-scroll-container"
    >
      <PostSkeleton v-if="currentItem === null || loading" />
      <div v-else>
        <div class="flex flex-col items-center">
          <img
            :src="currentItem.imageUrl"
            class="item-image"
            :alt="currentItem.title + currentItem.description"
          />
          <div class="flex flex-row w-full justify-between">
            <div class="flex flex-row items-center gap-2">
              <RouterLink
                :to="`/store/${currentItem.store.storeId}`"
                class="a-link-normal"
              >
                <img
                  :src="currentItem.store.profilePicture"
                  class="h-9 w-9 rounded-full object-cover hover:cursor-pointer"
                  :alt="currentItem.store.name"
                />
              </RouterLink>

              <RouterLink
                class="hover:cursor-pointer a-link-normal"
                :to="`/store/${currentItem.store.id}`"
                cl
              >
                <SheetTitle>{{ currentItem.store.name }}</SheetTitle>
                <SheetDescription class="text-pink-600 capitalize">
                  {{ currentItem.store.type }}
                </SheetDescription>
              </RouterLink>
            </div>

            <div class="flex flex-row items-center gap-2">
              <Button
                class="bg-pink-200 text-black hover:bg-transparent hover:text-pink-600 rounded-full w-30 h-30 m-0 p-1 flex items-center justify-center"
              >
                <AnOutlinedHeart class="text-xl" />
              </Button>
              <Button
                class="bg-pink-200 text-black hover:bg-transparent hover:text-pink-600 rounded-full w-30 h-30 m-0 p-1 flex items-center justify-center"
              >
                <ReSendPlaneFill class="text-xl" />
              </Button>
            </div>
          </div>
        </div>

        <div class="info-container">
          <h1
            class="text-3xl font-bold w-full text-center mb-4 mt-4 truncate overflow-hidden whitespace-nowrap"
          >
            {{ currentItem.name }}
          </h1>

          <div class="flex flex-row items-center justify-around">
            <div class="flex flex-row items-center gap-2">
              <Ratings :rating="4.5" />
              <p class="text-sm text-muted-foreground">(10 reviews)</p>
            </div>
            <p class="text-sm text-muted-foreground">20-30 minutes</p>
            <p class="text-sm text-muted-foreground capitalize">1 serving</p>
          </div>

          <p class="text-md mt-5">
            Lorem ipsum dolor sit amet consectetur, adipisicing elit. Numquam
            cumque sapiente animi, vero saepe eum omnis eligendi necessitatibus
            officia similique est doloremque vel nulla recusandae aut itaque
            optio repellat explicabo!
          </p>

          <div class="w-full mt-10 mb-10">
            <h2 class="text-lg font-bold mb-2">Ingredients</h2>
            <div class="flex flex-wrap gap-2">
              <p
                v-for="(allergen, index) in currentItem.ingredients"
                :key="index"
                class="bg-pink-200 w-fit rounded-full pr-3 pl-3 mr-1 text-black font-semibold"
              >
                {{ allergen }}
              </p>
            </div>
          </div>
        </div>

        <div>
          <div class="flex flex-row items-center gap-2 justify-between w-full">
            <h1
              class="text-2xl font-bold w-fit text-center mb-4 mt-4 truncate overflow-hidden whitespace-nowrap text-pink-600"
            >
              {{ currentItem.currency }} {{ currentItem.price }}
            </h1>
            <Button
              @click="addToCart"
              type="submit"
              class="bg-gradient-to-r from-pink-700 to-pink-400 h-[60px] w-50 rounded-2xl text-lg font-bold text-black hover:from-pink-500 hover:to-pink-500"
            >
              Add to Cart
            </Button>
          </div>
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
