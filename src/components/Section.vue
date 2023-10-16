<template>
  <section id="page">
    <h1>School Links</h1>
    <section id="links">
      <div class="grid-container">
        <a class="card" :class="{ locked: !unlocked }" :href="getLink1Url">
        <div class="head" style="background-color: rgba(255, 141, 71, 0.838);" id="first-head">
        <h3>ISTORIE</h3>
        </div>
        <p class="subject">Napoleon Bonaparte</p>
        <p class="date">16/10/2023</p>
      </a>
        <a class="card" :class="{ locked: !unlocked }" :href="getLink2Url">
        <div class="head" style="background-color: rgba(255, 71, 71, 0.838);">
        <h3>L. ROMÂNĂ</h3>
        </div>
        <p class="subject">CP - Casă & Pic</p>
        <p class="date">13/10/2023</p>
      </a>
      <a class="card" :class="{ locked: !unlocked }" :href="getLink3Url">
        <div class="head" style="background-color: rgba(145, 255, 0, 0.406);">
        <h3>L. ROMÂNĂ</h3>
        </div>
        <p class="subject">Ion Druță</p>
        <p class="date">06/10/2023</p>
      </a>
      <a class="card">

      </a>
      </div>
      </section>
      <p id="copyright">&copy; 2023 Gabs/Gabriel Cozma. All rights reserved.</p>
  </section>
    <input v-model="password" type="password" placeholder="Enter password" class="password-input" @keyup.enter="checkPassword">
</template>

<style scoped>
#page {
  margin: 0 auto;
  width: 1000px;
  height: 500px;
  padding: 40px;
  background-color: var(--color-background-section);
  border-radius: 23px;
  box-shadow: 0px 4px 56px 0px rgba(0, 0, 0, 0.25); 
}

#page h1 {
  font-weight: 900;
  font-size: 28px;
}
  
#page #copyright {
  text-align: right;
  margin-top: 10%;
  color: var(--color-text-dim);
  position: relative;
}

.grid-container {
  margin-top: 80px;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-gap: 2px;
  border-radius: 20px;
}

.card {
  background-color: var(--color-background-soft);
  padding: 20px;
  text-align: center;
  height: 200px;
  transition: background-color 300ms;
}

.card:hover {
  background-color: var(--color-background-mute);
}
.card:first-child {
  border-top-left-radius: 15px;
  border-bottom-left-radius: 15px;
}

.card:last-child {
  border-top-right-radius: 15px; 
  border-bottom-right-radius: 15px;
}

.card h3 {
  font-weight: 900;
  font-size: 25px;
  color: var(--color-text);
}

.card .date {
  color: var(--color-text);
  font-family: monospace;
}

.card .subject {
  margin-top: 50%;
  font-weight: 800;
}

.card > .head {
  text-align: center;
  height: 70px;
  text-align: center;
  margin: -20px;
  align-items: center;
  justify-content: center;
}

#first-head { 
  border-top-left-radius: 15px;
}

#last-head {
  border-top-right-radius: 15px;
}

.password-input {
  position: absolute;
  bottom: 0;
  right: 0;
  padding: 5px;
  border: 1px #fff;
  background-color: var(--color-background);
  color: var(--color-text);
  transition: color 300ms;
}
</style>

<script>
export default {
  data() {
    return {
      password: '',
      unlocked: false,
      showPasswordInput: false,
    };
  },
  computed: {
    getLink1Url() {
      return this.unlocked ? import.meta.env.VITE_LINK1 : null;
    },
    getLink2Url() {
      return this.unlocked ? import.meta.env.VITE_LINK2 : null;
    },
    getLink3Url() {
      return this.unlocked ? import.meta.env.VITE_LINK3 : null;
    },
  },
  methods: {
    checkPassword() {
  if (this.password === import.meta.env.VITE_PASSWORD_KEY) {
    this.unlocked = true;
    console.log('Password is correct. Unlocked:', this.unlocked);
    const passwordInput = document.querySelector(".password-input");
    if (passwordInput) {
      passwordInput.style.color = "hsla(160, 100%, 37%, 1)";
    }
  } else {
    console.log('Incorrect password.');
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
},
    togglePasswordInput() {
      this.showPasswordInput = !this.showPasswordInput;
    },
  },
};
</script>