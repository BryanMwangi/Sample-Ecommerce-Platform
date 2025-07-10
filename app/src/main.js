import "./assets/main.css";
import "instantsearch.css/themes/satellite.css";
import { createApp } from "vue";
import { createPinia } from "pinia";
import mitt from "mitt";
import MasonryWall from "@yeger/vue-masonry-wall";
import InstantSearch from "vue-instantsearch/vue3/es";

import App from "./App.vue";
import router from "./router";

import "./assets/base.css";

const emitter = mitt();
const app = createApp(App);
const pinia = createPinia();

app.config.globalProperties.emitter = emitter;
app.use(MasonryWall);
app.use(pinia);
app.use(router);
app.use(InstantSearch);
app.mount("#app");
