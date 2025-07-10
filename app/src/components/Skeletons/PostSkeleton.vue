<script setup>
import { Skeleton } from "@/components/ui/skeleton";
</script>

<template>
  <div class="flex items-center flex-col gap-5">
    <Skeleton class="h-[300px] w-[80%] rounded-3xl" />
    <div class="space-y-2 w-[80%] gap-2 flex flex-col">
      <Skeleton class="h-6 w-[80%] rounded-3xl" />
      <Skeleton class="h-6 w-[180px] rounded-3xl" />
    </div>
  </div>
</template>
