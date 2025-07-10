<script setup>
import { onMounted, ref, watch } from "vue";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import MasonryAction from "../../MasonryAction/MasonryAction.vue";
import ItemView from "../../ItemView/ItemView.vue";
import { useUserStore } from "@/stores/user";
import { useOrderStore } from "@/stores/orders";

const props = defineProps({
  screenName: {
    type: String,
    required: true,
  },
  userName: {
    type: Number,
    required: true,
  },
});
const userStore = useUserStore();
const ordersStore = useOrderStore();
const userName = ref(props.userName);
const items = ref([]);
const open = ref(false);
const selected = ref(null);

const handleSelect = (item) => {
  selected.value = item;
  open.value = true;
};

const handleClose = () => {
  open.value = false;
};

watch(
  () => props.userName,
  (newVal) => {
    userName.value = newVal;
    // we will use the userName in the future
    items.value = userStore.orders;
  },
  { immediate: true }
);

onMounted(async () => {
  const results = await ordersStore.fetchAllOrders();
  console.log(results);
  items.value = results;
});
</script>

<template>
  <Tabs default-value="Orders" class="w-full mt-10">
    <TabsList class="grid w-full bg-transparent flex flex-row gap-10">
      <TabsTrigger
        value="Orders"
        class="data-[state=active]:border-b-2 data-[state=active]:border-pink-600 rounded-none w-[100px]"
        >Orders
      </TabsTrigger>
      <TabsTrigger
        value="Liked"
        class="data-[state=active]:border-b-2 data-[state=active]:border-pink-600 rounded-none w-[100px]"
      >
        Liked
      </TabsTrigger>
      <TabsTrigger
        value="Reviews"
        class="data-[state=active]:border-b-2 data-[state=active]:border-pink-600 rounded-none w-[100px]"
      >
        Reviews
      </TabsTrigger>
    </TabsList>
    <TabsContent value="Orders">
      <masonry-wall
        :items="items"
        :ssr-columns="1"
        :column-width="260"
        :gap="16"
        class="mb-10 px-10"
      >
        <template #default="{ item, index }">
          <div class="item">
            <img :src="item?.items[0]?.imageUrl" alt="" class="image" />
            <h1
              class="text-lg font-semibold truncate max-w-[300px] overflow-hidden whitespace-nowrap"
            >
              Order Id: {{ item?.id }}
            </h1>
            <div
              class="flex flex-row items-center gap-2 text-md font-semibold mt-2"
            >
              <p>{{ item?.currency }}</p>
              <p>{{ item?.total }}</p>
            </div>
          </div>
        </template>
      </masonry-wall>
    </TabsContent>
    <TabsContent value="Liked">
      <div class="flex flex-col items-center justify-center mt-10">
        <h1 class="text-2xl font-bold w-full text-center">
          Unavailable at this time
        </h1>
        <p class="text-center text-muted-foreground text-lg mt-2">
          Check back later and we will add your liked posts here
        </p>
      </div>
    </TabsContent>
    <TabsContent value="Reviews">
      <div class="flex flex-col items-center justify-center mt-10">
        <h1 class="text-2xl font-bold w-full text-center">
          Unavailable at this time
        </h1>
        <p class="text-center text-muted-foreground text-lg mt-2">
          Check back later and we will add your reviews here
        </p>
      </div>
    </TabsContent>
  </Tabs>
</template>

<style>
.item {
  padding-right: 10px;
  padding-left: 10px;
  padding-top: 10px;
  padding-bottom: 30px;
  height: max-content;
  width: 260px;
  border-radius: 12px;
  transition: background-color 0.3s ease;
}
.item:hover {
  background-color: rgba(240, 110, 166, 0.45);
  cursor: pointer;
}
.image {
  height: auto;
  width: 240px;
  border-radius: 12px;
}
</style>
