<template>
  <section id="page">
    <h1>School Links</h1>
    <section id="links">
      <div class="grid-container">
        <a class="card" :class="{ locked: !unlocked }" :href="getLink1Url">
        <div class="head" id="first-head" style="background-color: #ff5151;">
        <h3>L. ROMÂNĂ</h3>
        </div>
        <p class="subject">CP - Casă</p>
        <p class="date">13/10/2023</p>
      </a>
      <a class="card" :class="{ locked: !unlocked }" :href="getLink2Url">
        <div class="head" style="background-color: #968b2f;">
        <h3>L. ROMÂNĂ</h3>
        </div>
        <p class="subject">Ion Druță</p>
        <p class="date">06/10/2023</p>
      </a>
      <a class="card">

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
    grid-template-columns: repeat(4, 1fr); /* Two columns */
    grid-gap: 2px; /* 1px gap between cards */
    border-radius: 20px;
}

.card {
    background-color: var(--color-background-soft); /* Card background color */
    padding: 20px;
    text-align: center;
    height: 200px;
    transition: background-color 300ms;
}

.card:hover {
  background-color: var(--color-background-mute);
}
.card:first-child {
  border-top-left-radius: 15px; /* Top-left rounded corner for the first card */
  border-bottom-left-radius: 15px; /* Bottom-left rounded corner for the first card */
}

.card:last-child {
  border-top-right-radius: 15px; /* Top-right rounded corner for the last card */
  border-bottom-right-radius: 15px; /* Bottom-right rounded corner for the last card */
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
  align-items: center; /* Center horizontally */
    justify-content: center; /* Center vertically */
  }

  #first-head { 
  border-top-left-radius: 15px; /* Top-left rounded corner for the first card */
}

.toggle-password {
  position: relative;
}

.password-input {
  position: absolute;
  bottom: 0;
  right: 0;
  padding: 5px;
  border: 1px #fff;
  background-color: var(--color-background);
  color: var(--color-text);
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
      return this.unlocked ? process.env.VITE_LINK1 : null;
    },
    getLink2Url() {
      return this.unlocked ? process.env.VITE_LINK2 : null;
    },
  },
  methods: {
    checkPassword() {
      if (this.password === process.env.VITE_PASSWORD_KEY) {
        this.unlocked = true;
        console.log('Password is correct. Unlocked:', this.unlocked);
      } else {
        console.log('Incorrect password.');
      }
    },
    togglePasswordInput() {
      this.showPasswordInput = !this.showPasswordInput;
    },
  },
};
</script>