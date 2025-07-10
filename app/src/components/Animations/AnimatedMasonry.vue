<script setup>
import { onMounted, onUnmounted, ref } from "vue";
import { animation_data } from "./animation_data";
const MIN_IMAGE_HEIGHT = 240;
const IMAGE_WIDTH = 240;

const screenWidth = ref(window.innerWidth);
const screenHeight = ref(window.innerHeight);
const animationData = ref([]);

// Listen for window resize to dynamically adjust layout
const updateScreenSize = () => {
  screenWidth.value = window.innerWidth;
  screenHeight.value = window.innerHeight;
};

window.addEventListener("resize", updateScreenSize);

// Repeat images vertically to fill the column height
const repeatImagesToFitScreenHeight = (imageArray, imageHeight) => {
  const totalImageHeight = imageArray.length * imageHeight;
  if (totalImageHeight < screenHeight.value) {
    const repeatFactor = Math.ceil(screenHeight.value / totalImageHeight);
    return Array(repeatFactor).fill(imageArray).flat();
  }
  return imageArray;
};

// Calculate the number of columns needed to fill the screen width
const numberOfColumnsToRender = (dataLength) => {
  const totalWidth = dataLength * IMAGE_WIDTH;
  return totalWidth >= screenWidth.value
    ? dataLength
    : Math.ceil(screenWidth.value / IMAGE_WIDTH);
};

// First render logic to create columns and calculate number of rows for each column
const firstRender = () => {
  let finalItems = [];

  // Iterate over each column of images
  for (const column of animation_data) {
    // Repeat the images in each column vertically to fit screen height
    let repeatedImages = repeatImagesToFitScreenHeight(
      column,
      MIN_IMAGE_HEIGHT
    );

    finalItems.push({
      images: repeatedImages, // Images for this column, repeated if needed
      length: repeatedImages.length, // Number of images in the column
    });
  }

  // Calculate how many columns we need to fill the screen width
  let numColumns = numberOfColumnsToRender(finalItems.length);

  // Prepare the final animation data by repeating the columns horizontally if necessary
  const repeatedColumns = [];
  for (let i = 0; i < numColumns; i++) {
    repeatedColumns.push(...finalItems); // Repeat the entire array of columns
  }

  // Set the data for rendering, slicing if necessary
  animationData.value = repeatedColumns.slice(0, numColumns);
};

function getColumnClass(index) {
  // Alternate the scroll direction based on the column index
  return index % 2 === 0 ? "animate-scroll-up" : "animate-scroll-down";
}

// Call firstRender on mounted
onMounted(() => {
  firstRender();
  window.addEventListener("resize", firstRender); // Recalculate on window resize
});

// Clean up event listener on unmount
onUnmounted(() => {
  window.removeEventListener("resize", firstRender);
});
</script>

<template>
  <div
    class="masonry-animation-container"
    v-for="(column, columnIndex) in animationData"
    :key="columnIndex"
  >
    <div
      class="masonry-column"
      v-for="(item, itemIndex) in column.images"
      :key="`${columnIndex}-${itemIndex}`"
      :class="getColumnClass(itemIndex)"
    >
      <div class="masonry-item">
        <img :src="item" alt="" class="image" />
      </div>
    </div>
  </div>
</template>

<style scoped>
.masonry-animation-container {
  display: flex;
  width: 100vw; /* Full width */
  flex-direction: row;
  gap: 16px;
  justify-content: space-evenly;
  align-items: center;
  max-width: 100vw;
}

.masonry-column {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
  max-width: 240px;
  animation: fadeIn 2s ease-out; /* Animate each column */
}
.animate-scroll-up {
  animation: animateScrollUp 12s cubic-bezier(0.5, 0, 0.5, 1) infinite alternate;
}
.animate-scroll-down {
  animation: animateScrollDown 12s cubic-bezier(0.5, 0, 0.5, 1) infinite
    alternate;
}

.masonry-item {
  width: 240px;
  height: auto;
}

.image {
  height: auto;
  width: 240px;
  border-radius: 12px;
}

@keyframes animateScrollUp {
  from {
    transform: translateY(120px);
  }
  to {
    transform: translateY(0);
  }
}
@keyframes animateScrollDown {
  from {
    transform: translateY(-120px);
  }
  to {
    transform: translateY(0);
  }
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
</style>
