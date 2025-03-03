<script setup lang="ts">
import { useData } from "vitepress";
import { ref, onMounted, onUnmounted } from "vue";

const password = ref("");
const unlocked = ref(false);
const showPopup = ref(false);
const showPasswordInput = ref(false);

const togglePasswordPopup = () => {
    showPopup.value = !showPopup.value;
    if (unlocked.value === true) {
        showPopup.value = false;
        unlocked.value = false;
        password.value = "";
    }
};

const getLinkUrl = (index: number) => {
    if (unlocked.value) {
        const link = (import.meta as any).env[`VITE_LINK${index + 1}`];
        return link ? link : null;
    }
    return null;
};

const checkPassword = () => {
    const passwordInput = document.querySelector(
        "input[type='password']",
    ) as HTMLInputElement;

    const lock = document.querySelector("#lock") as HTMLButtonElement;

    if (password.value === (import.meta as any).env.VITE_PASSWORD_KEY) {
        unlocked.value = true;
        setTimeout(() => {
            showPopup.value = false;
        }, 1200);
        console.log("Password is correct. Unlocked:", unlocked.value);
        if (passwordInput) {
            passwordInput.style.color = "hsla(160, 100%, 37%, 1)";
            lock.style.filter =
                "invert(75%) sepia(100%) saturate(300%) hue-rotate(90deg) brightness(100%) contrast(100%)";
        }
    } else {
        console.log("Incorrect password. Unlocked:", unlocked.value);
        if (passwordInput) {
            passwordInput.style.color = "rgba(255, 71, 71, 0.838)";
            passwordInput.style.animation = "shakeAnimation 0.5s";
        }
    }
    setTimeout(() => {
        if (passwordInput) {
            passwordInput.style.color = "";
            passwordInput.style.animation = "";
            lock.style.filter = "";
        }
    }, 2000);
};

const togglePasswordInput = () => {
    showPasswordInput.value = !showPasswordInput.value;
};

onMounted(() => {
    document.addEventListener("keydown", handleEscKey);
});

onUnmounted(() => {
    document.removeEventListener("keydown", handleEscKey);
});

const handleEscKey = (e: KeyboardEvent) => {
    if (e.key === "Escape") {
        showPopup.value = false;
    }
};

const { frontmatter, theme, site } = useData();
</script>

<template>
    <section id="page">
        <h1>{{ site.title }}</h1>
        <section id="links">
            <div id="cards">
                <template
                    v-for="(card, index) in frontmatter.cards"
                    :key="index"
                >
                    <a
                        class="card"
                        :class="{ locked: !unlocked }"
                        :href="getLinkUrl(index)"
                    >
                        <div
                            class="head"
                            :style="'background-color:' + card.color"
                        >
                            <h3>{{ card.subject }}</h3>
                        </div>
                        <div
                            class="foot"
                            v-if="card.details || card.date !== ''"
                        >
                            <p class="subject" v-if="card.details">
                                {{ card.details }}
                            </p>
                            <p class="date" v-if="card.date">{{ card.date }}</p>
                        </div>
                    </a>
                </template>
            </div>
        </section>
        <p id="copyright" v-if="theme?.copyright !== false || theme.author">
            &copy; {{ new Date().getFullYear() }}
            <a v-if="theme.author" :href="theme.author.link">{{
                theme.author.name
            }}</a
            >. All rights reserved.
        </p>
    </section>
    <button @click="togglePasswordPopup" id="lock">
        <img src="./assets/unlocked.svg" v-if="unlocked" />
        <img src="./assets/lock.svg" v-else />
    </button>

    <Transition>
        <template v-if="showPopup">
            <div id="popup">
                <div id="overlay" @click="togglePasswordPopup">
                    <div id="content" @click.stop>
                        <a id="close" @click="togglePasswordPopup">×</a>
                        <div id="main-content">
                            <h2>Password</h2>
                            <p>
                                Please enter the password to verify your
                                authorization to access these links.
                            </p>
                            <input
                                v-model="password"
                                type="password"
                                placeholder="Enter password"
                                @keyup.enter="checkPassword"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </template>
    </Transition>
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
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
    box-shadow: var(--base-shadow);
    border-radius: 1.3rem;
    background-color: var(--color-background-section);
    padding: 2.5rem;
    width: 100%;
    height: max-content;

    h1 {
        font-weight: 900;
        font-size: 1.75rem;
    }

    #cards {
        gap: 0.125rem;
        border-radius: 1.3rem;
        overflow: hidden;
        display: grid;
        grid-template-columns: repeat(4, 1fr);

        .card {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: 2rem;
            padding-bottom: 1.25rem;
            transition: background-color 300ms;
            background-color: var(--color-background-soft);
            min-width: 12rem;
            max-width: 12rem;
            min-height: max-content;
            height: 100%;
            text-align: center;

            &:hover {
                background-color: var(--color-background-mute);
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
                max-width: 100%;
                padding: 1.25rem;
                height: 5rem;

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
                padding: 0 1.25rem;
                text-align: center;
            }
        }
    }

    #copyright {
        position: relative;
        color: var(--color-text-dim);
        font-weight: 500;
        text-align: right;

        a {
            color: var(--color-text-dim);
            font-weight: bolder;
            text-decoration: underline;

            &:hover {
                color: var(--color-text);
                text-decoration: underline dotted;
            }
        }
    }
}

#lock {
    display: flex;
    position: fixed;
    right: 1.25rem;
    bottom: 1.25rem;
    justify-content: center;
    align-items: center;
    transition:
        background-color 300ms,
        filter 500ms;
    cursor: pointer;
    box-shadow: var(--base-shadow);
    border: 0;
    border-radius: 0.625rem;
    background-color: var(--color-background);
    padding: 0.6rem;
    color: var(--color-text);
    font-weight: 800;
    font-size: 1rem;

    @media (prefers-color-scheme: dark) {
        background-color: var(--color-background-soft);
    }

    &:hover {
        background-color: var(--color-background-mute);
    }
}

#popup {
    display: flex;
    position: fixed;
    top: 0;
    left: 0;
    justify-content: center;
    align-items: center;
    z-index: 1000;
    width: 100%;
    height: 100%;

    #overlay {
        display: flex;
        position: absolute;
        justify-content: center;
        align-items: center;
        backdrop-filter: blur(0.525rem);
        transition: backdrop-filter 300ms;
        background-color: rgba(140, 149, 159, 0.2);
        width: 100%;
        height: 100%;

        @media (prefers-color-scheme: dark) {
            background-color: rgba(0, 0, 0, 0.496);
        }
    }

    #content {
        position: relative;
        box-shadow: var(--base-shadow);
        border-radius: 0.625rem;
        background-color: var(--color-background);
        padding: 2.3rem 1.8rem;
        width: 30%;
        height: max-content;

        #main-content {
            display: flex;
            flex-direction: column;
            justify-content: start;
            align-items: start;
            gap: 0.7rem;
            width: 100%;
            height: max-content;

            h2 {
                font-weight: 900;
                font-size: 1.7rem;
                line-height: 1.7rem;
            }

            p {
                font-weight: 500;
                font-size: 1rem;
            }

            input[type="password"] {
                transition: color 300ms;
                border: 0;
                border-radius: 0.625rem;
                background-color: var(--color-background-mute);
                padding: 1rem;
                width: 100%;
                color: var(--color-text);
                font-size: 1rem;
                font-family: "Inter", sans-serif;

                @media (prefers-color-scheme: dark) {
                    background-color: var (--color-background-soft);
                }
            }
        }

        #close {
            position: absolute;
            top: 0.2rem;
            right: 1rem;
            cursor: pointer;
            padding: 0.625rem;
            color: var(--color-text);
            font-size: 1.5rem;

            &:hover {
                opacity: 0.8;
            }
        }
    }
}

.v-enter-active,
.v-leave-active {
    backdrop-filter: blur(0.625rem);
    transition: opacity 0.5s ease;
}

.v-enter-from,
.v-leave-to {
    opacity: 0;
    backdrop-filter: 0;
}

@keyframes shakeAnimation {
    0% {
        transform: translateX(0);
    }
    25% {
        transform: translateX(-0.5rem);
    }
    50% {
        transform: translateX(0.5rem);
    }
    75% {
        transform: translateX(-0.5rem);
    }
    100% {
        transform: translateX(0);
    }
}
</style>
