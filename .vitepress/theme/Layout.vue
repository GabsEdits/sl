<script setup lang="ts">
import { useData } from "vitepress";
import { ref } from "vue";

const password = ref("");
const unlocked = ref(false);
const showPasswordInput = ref(false);

const getLinkUrl = (index: number) => {
  if (unlocked.value) {
    const link = import.meta.env[`VITE_LINK${index + 1}`];
    return link ? link : null;
  }
  return null;
};

const checkPassword = () => {
  if (password.value === import.meta.env.VITE_PASSWORD_KEY) {
    unlocked.value = true;
    console.log("Password is correct. Unlocked:", unlocked.value);
    const passwordInput = document.querySelector(".password-input");
    if (passwordInput) {
      passwordInput.style.color = "hsla(160, 100%, 37%, 1)";
    }
  } else {
    console.log("Incorrect password.");
    const passwordInput = document.querySelector(".password-input");
    if (passwordInput) {
      passwordInput.style.color = "rgba(255, 71, 71, 0.838)";
    }
  }
  setTimeout(() => {
    const passwordInput = document.querySelector(".password-input");
    if (passwordInput) {
      passwordInput.style.color = "";
    }
  }, 2000);
};

const togglePasswordInput = () => {
  showPasswordInput.value = !showPasswordInput.value;
};

const { frontmatter, theme } = useData();
</script>

<template>
  <section id="page">
    <h1>School Links</h1>
    <section id="links">
      <div class="grid-container">
        <template v-for="(card, index) in frontmatter.cards" :key="index">
          <a
            class="card"
            :class="{ locked: !unlocked }"
            :href="getLinkUrl(index)"
          >
            <div class="head" :style="'background-color:' + card.color">
              <h3>{{ card.subject }}</h3>
            </div>
            <p class="subject">{{ card.details }}</p>
            <p class="date">{{ card.date }}</p>
          </a>
        </template>
      </div>
    </section>
    <p id="copyright">
      &copy; {{ new Date().getFullYear() }} {{ theme.author }}. All rights
      reserved.
    </p>
  </section>
  <input
    v-model="password"
    type="password"
    placeholder="Enter password"
    class="password-input"
    @keyup.enter="checkPassword"
  />
</template>
