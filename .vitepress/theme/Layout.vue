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
    const passwordInput = document.querySelector("input[type='password']");
    if (passwordInput) {
      passwordInput.style.color = "hsla(160, 100%, 37%, 1)";
    }
  } else {
    console.log("Incorrect password.");
    const passwordInput = document.querySelector("input[type='password']");
    if (passwordInput) {
      passwordInput.style.color = "rgba(255, 71, 71, 0.838)";
    }
  }
  setTimeout(() => {
    const passwordInput = document.querySelector("input[type='password']");
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
      <div id="cards">
        <template v-for="(card, index) in frontmatter.cards" :key="index">
          <a
            class="card"
            :class="{ locked: !unlocked }"
            :href="getLinkUrl(index)"
          >
            <div class="head" :style="'background-color:' + card.color">
              <h3>{{ card.subject }}</h3>
            </div>
            <div class="foot">
              <p class="subject">{{ card.details }}</p>
              <p class="date">{{ card.date }}</p>
            </div>
          </a>
        </template>
      </div>
    </section>
    <p id="copyright">
      &copy; {{ new Date().getFullYear() }}
      <a :href="theme.author.link">{{ theme.author.name }}</a
      >. All rights reserved.
    </p>
  </section>
  <input
    v-model="password"
    type="password"
    placeholder="Enter password"
    @keyup.enter="checkPassword"
  />
</template>

<style lang="scss">
a,
.green {
  transition: 0.4s;
  color: hsla(160, 100%, 37%, 1);
  text-decoration: none;
}

#page {
  animation: fadeInAnimation ease 1.5s;
  animation-iteration-count: 1;
  animation-fill-mode: forwards;
  box-shadow: var(--base-shadow);
  border-radius: 1.3rem;
  background-color: var(--color-background-section);
  padding: 2.5rem;
  width: 100%;
  height: max-content;

  h1 {
    margin-bottom: 1.5rem;
    font-weight: 900;
    font-size: 1.75rem;
  }

  #cards {
    grid-gap: 0.125rem;
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    border-radius: 1.25rem;

    .card {
      display: grid;
      transition: background-color 300ms;
      background-color: var(--color-background-soft);
      height: max-content;
      text-align: center;

      &:hover {
        background-color: var(--color-background-mute);
      }

      &:first-child {
        border-top-left-radius: 0.9375rem;
        border-bottom-left-radius: 0.9375rem;

        .head {
          border-top-left-radius: 0.9375rem;
        }
      }

      &:last-child {
        border-top-right-radius: 0.9375rem;
        border-bottom-right-radius: 0.9375rem;

        .head {
          border-top-right-radius: 0.9375rem;
        }
      }

      .subject {
        font-weight: 800;
      }

      .date {
        color: var(--color-text);
        font-size: 0.8125rem;
        font-family: "Source Code Pro", monospace;
      }

      .head {
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 1.25rem;

        h3 {
          color: var(--color-text);
          font-weight: 900;
          font-size: 1.5625rem;
        }
      }

      .foot {
        display: flex;
        flex-direction: column;
        justify-content: center;
        background-color: transparent;
        padding: 2.5rem 1.25rem 1rem 1.25rem;
        text-align: center;
      }
    }
  }

  #copyright {
    position: relative;
    margin-top: 5%;
    color: var(--color-text-dim);
    font-weight: 500;
    text-align: right;

    a {
      color: var(--color-text-dim);
      text-decoration: underline;
      font-weight: bolder;

      &:hover {
        color: var(--color-text);
        text-decoration: underline dotted;
      }
    }
  }
}

input[type="password"] {
  position: absolute;
  right: 0;
  bottom: 0;
  transition: color 300ms;
  border: 0.0625rem #fff;
  background-color: var(--color-background);
  padding: 0.3125rem;
  color: var(--color-text);
}
</style>
