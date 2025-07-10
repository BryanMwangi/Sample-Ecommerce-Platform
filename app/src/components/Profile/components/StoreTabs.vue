<script setup>
import { computed, ref, watch } from "vue";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import MasonryAction from "../../MasonryAction/MasonryAction.vue";
import ItemView from "../../ItemView/ItemView.vue";
import { usePostsStore } from "@/stores/posts";
import { un } from "@/stores/validators";

const props = defineProps({
  screenName: {
    type: String,
    required: true,
  },
  storeId: {
    type: Number,
    required: true,
  },
});
const postsStore = usePostsStore();
const items = ref([]);
const open = ref(false);
const selected = ref(null);
const loading = ref(true);

const handleSelect = (item) => {
  selected.value = item.id;
  open.value = true;
};

const handleClose = () => {
  open.value = false;
};

const fetchItems = async (id) => {
  try {
    if (id === null || id === undefined) {
      return;
    }
    const results = await postsStore.fetchStorePosts(id);
    items.value = [...results];
  } catch (error) {
    console.log(error);
  } finally {
    loading.value = false;
  }
};

const categories = computed(() => {
  try {
    if (items.value.length === 0) {
      return [];
    }
    return Object.values(
      items.value.reduce((acc, item) => {
        const category = item.category;
        if (!acc[category]) {
          acc[category] = {
            items: [],
            category: category,
          };
        }
        acc[category].items.push({ ...item });
        return acc;
      }, {})
    );
  } catch (error) {
    console.log(error);
    return [];
  }
});

const parseCategory = (category) => {
  let name = un(category);
  return name.charAt(0).toUpperCase() + name.slice(1);
};

watch(
  () => props.storeId,
  (newVal) => {
    fetchItems(newVal);
  },
  { immediate: true }
);
</script>

<template>
  <Tabs default-value="Items" class="w-full mt-10">
    <TabsList class="grid w-full bg-transparent flex flex-row gap-10">
      <TabsTrigger
        value="Items"
        class="data-[state=active]:border-b-2 data-[state=active]:border-pink-600 rounded-none w-[100px]"
        >Items
      </TabsTrigger>
      <TabsTrigger
        value="Categories"
        class="data-[state=active]:border-b-2 data-[state=active]:border-pink-600 rounded-none w-[100px]"
      >
        Categories
      </TabsTrigger>
      <TabsTrigger
        value="Reviews"
        class="data-[state=active]:border-b-2 data-[state=active]:border-pink-600 rounded-none w-[100px]"
      >
        Reviews
      </TabsTrigger>
    </TabsList>
    <TabsContent value="Items">
      <masonry-wall
        :items="items"
        :ssr-columns="1"
        :column-width="260"
        :gap="16"
        class="mb-10 px-10"
      >
        <template #default="{ item }">
          <div class="item">
            <img
              :src="item.imageUrl"
              alt=""
              class="image"
              @click="handleSelect(item)"
            />
            <MasonryAction
              :title="item.name"
              :price="item.price"
              :currency="item.currency"
              :profilePicture="item.store.profilePicture"
              @select="handleSelect(item)"
            />
          </div>
        </template>
      </masonry-wall>
    </TabsContent>
    <TabsContent value="Categories">
      <div v-for="(category, index) in categories" :key="index">
        <h1 class="text-3xl font-bold w-full pl-10 text-left mb-4">
          {{ parseCategory(category.category) }}
        </h1>
        <masonry-wall
          :items="category.items"
          :ssr-columns="1"
          :column-width="260"
          :gap="16"
          class="mb-10 px-10"
        >
          <template #default="{ item }">
            <div class="item">
              <img
                :src="item.imageUrl"
                alt=""
                class="image"
                @click="handleSelect(item)"
              />
              <MasonryAction
                :title="item.name"
                :price="item.price"
                :currency="item.currency"
                :profilePicture="item.store.profilePicture"
                @select="handleSelect(item)"
              />
            </div>
          </template>
        </masonry-wall>
      </div>
    </TabsContent>
    <TabsContent value="Reviews">
      <div class="flex flex-col items-center justify-center mt-10">
        <h1 class="text-2xl font-bold w-full text-center">
          Unavailable at this time
        </h1>
        <p class="text-center text-muted-foreground text-lg mt-2">
          Check back later and we will add reviews for this store
        </p>
      </div>
    </TabsContent>
  </Tabs>
  <ItemView :open="open" :itemId="selected" @close="handleClose" />
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
