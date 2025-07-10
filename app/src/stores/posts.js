import { defineStore } from "pinia";
import { ServerClient } from "./auth";
import { un } from "./validators";

export const usePostsStore = defineStore("posts", {
  state: () => ({
    posts: [],
    searchResults: [],
    categories: [],
    stores: [],
    topPosts: [],
    setPage: 1,
  }),
  actions: {
    async fetchPosts(page, category) {
      try {
        let query = `/posts?page=${page}`;
        if (category && category !== "" && category !== undefined) {
          query = `/posts?page=${page}&category=${category}`;
        }
        const response = await ServerClient.get(query);
        return response.data || [];
      } catch (error) {
        return [];
      }
    },

    async searchPost(query) {
      try {
        if (!query) {
          return [];
        }
        const response = await ServerClient.get(`/search?q=${query}`);
        return response.data || [];
      } catch (error) {
        return [];
      }
    },

    async fetchPostById(id) {
      const response = await ServerClient.get(`/fetchPost/${id}`);
      return response.data;
    },

    async fetchCategories() {
      const response = await ServerClient.get(`/fetchCategories`);
      for (const item of response.data) {
        let name = item.name;
        name = name.charAt(0).toUpperCase() + name.slice(1);
        if (!this.categories.some((category) => category.name === un(name))) {
          const category = {
            name: un(name),
            originalName: item.name,
          };
          this.categories.push(category);
        }
      }
    },

    async fetchAllStores() {
      const response = await ServerClient.get(`/fetchAllStores`);
      this.stores = response.data;
    },

    async fetchStoreById(id) {
      const response = await ServerClient.get(`/fetchStore/${id}`);
      return response.data;
    },

    async fetchStorePosts(id) {
      const response = await ServerClient.get(`/fetchStorePosts/${id}`);
      return response.data || [];
    },

    async fetchStoreHours(id) {
      if (id === null || id === undefined) {
        return [];
      }
      const weekdays = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
      ];
      let day = weekdays[new Date().getDay()];

      const response = await ServerClient.get(
        `/fetchStoreHours/${id}?day=${day}`
      );
      return response.data || [];
    },
  },
});
