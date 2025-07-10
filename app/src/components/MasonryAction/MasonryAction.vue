<script setup>
import { Button } from "@/components/ui/button";
import { AnOutlinedHeart } from "@kalimahapps/vue-icons";
import { ReSendPlaneFill } from "@kalimahapps/vue-icons";
import { MessageCircle } from "lucide-vue-next";
import {
  Tooltip,
  TooltipContent,
  TooltipTrigger,
} from "@/components/ui/tooltip";
const props = defineProps({
  title: String,
  price: Number,
  currency: String,
  profilePicture: String,
});

const emit = defineEmits(["select"]);
</script>

<template>
  <div class="masonry-action">
    <img
      :src="props.profilePicture"
      alt="profile picture"
      class="h-8 w-8 rounded-full object-cover"
    />

    <div class="flex flex-col w-full mt-5 ml-2">
      <h1
        class="text-1xl font-bold truncate max-w-48 overflow-hidden whitespace-nowrap"
      >
        {{ title }}
      </h1>

      <div class="flex flex-row items-center">
        <Tooltip>
          <TooltipTrigger>
            <Button
              class="bg-transparent text-muted-foreground hover:bg-transparent hover:text-pink-600 rounded-full m-0 p-0"
            >
              <AnOutlinedHeart class="text-xl" />
            </Button>
          </TooltipTrigger>

          <TooltipContent>
            <p>Like</p>
          </TooltipContent>
        </Tooltip>
        <Tooltip>
          <TooltipTrigger>
            <Button
              @click="emit('select')"
              class="bg-transparent text-muted-foreground hover:bg-transparent hover:text-pink-600 rounded-full mt-0 mb-0 mr-1 ml-1 p-1"
            >
              <MessageCircle size="20" />
            </Button>
          </TooltipTrigger>
          <TooltipContent>
            <p>Reviews</p>
          </TooltipContent>
        </Tooltip>
        <Tooltip>
          <TooltipTrigger>
            <Button
              class="bg-transparent text-muted-foreground hover:bg-transparent hover:text-pink-600 rounded-full m-0 p-0"
            >
              <ReSendPlaneFill class="text-xl" />
            </Button>
          </TooltipTrigger>
          <TooltipContent>
            <p>Share</p>
          </TooltipContent>
        </Tooltip>
      </div>
    </div>

    <h2 class="text-pink-600 font-bold absolute bottom-0 right-0">
      {{ currency }} {{ price }}
    </h2>
  </div>
</template>

<style scoped>
.masonry-action {
  display: flex;
  flex-direction: row;
  position: relative;
  height: 60px;
  align-items: center;
  max-width: 100%;
  overflow: hidden;
}
</style>
