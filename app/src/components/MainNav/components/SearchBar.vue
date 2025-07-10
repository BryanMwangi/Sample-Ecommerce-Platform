<script setup>
import router from "@/router";
import TypesenseInstantSearchAdapter from "typesense-instantsearch-adapter";
import { ref } from "vue";
import { RouterLink } from "vue-router";

const typesenseInstantsearchAdapter = new TypesenseInstantSearchAdapter({
  server: {
    apiKey: import.meta.env.VITE_TYPESENSE_SEARCH_KEY,
    nodes: [
      {
        host: import.meta.env.VITE_TYPESENSE_URL,
        port: import.meta.env.VITE_TYPESENSE_PORT,
        protocol: "https",
      },
    ],
    cacheSearchResultsForSeconds: 2 * 60,
  },
  additionalSearchParameters: {
    query_by: "name,ingredients,category",
  },
});
const searchClient = typesenseInstantsearchAdapter.searchClient;

const isFocused = ref(false);

const extractUniquHits = (list) => {
  let uniqueList = [];
  if (!list && list.length === 0) {
    return;
  }
  for (const item of list) {
    if (!uniqueList.includes(item.name)) {
      uniqueList.push(item.name);
    }
  }
  return uniqueList;
};

const delayOnBlur = () => {
  setTimeout(() => {
    isFocused.value = false;
  }, 200);
};

const handleSubmit = (event) => {
  const query = event.target.value;
  router.push(`/search?q=${query}`);
};
</script>
<template>
  <ais-instant-search :search-client="searchClient" index-name="items">
    <div class="searchbox">
      <ais-search-box
        placeholder="search"
        @focus="isFocused = true"
        @blur="delayOnBlur"
        @keydown.enter="handleSubmit"
      />
    </div>

    <div class="hits" v-if="isFocused">
      <ais-hits>
        <template v-slot="{ items }">
          <div v-for="item in extractUniquHits(items)">
            <RouterLink
              class="ais-Hits-item a-link-opaque"
              :to="`search?q=${item}`"
            >
              <h2 class="text-1xl font-bold text-foreground">
                {{ item }}
              </h2>
            </RouterLink>
          </div>
        </template>
      </ais-hits>
    </div>
  </ais-instant-search>
</template>
<style scoped>
.search-panel {
  display: flex;
}

.search-panel__filters {
  flex: 1;
}

.search-panel__results {
  flex: 3;
}
.ais-InstantSearch {
  position: relative;
  border-radius: 24px;
}

.ais-SearchBox-form {
  border-radius: 24px;
}
.searchbox {
  border-radius: 24px;
  margin-bottom: 10px;
  overflow: hidden;
}
.hits {
  border-radius: 16px;
  overflow: hidden;
}
</style>
