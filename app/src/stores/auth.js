import { defineStore } from "pinia";
import axios from "axios";
import { toast } from "vue-sonner";
import { en, ve, vn, vp } from "./validators";

export const ServerClient = axios.create({
  baseURL: import.meta.env.VITE_API_URL,
  withCredentials: true,
  headers: {
    "Content-Type": "application/json",
  },
});

ServerClient.interceptors.response.use(
  (response) => {
    return response;
  },
  (error) => {
    if (error.response) {
      if (error.response.status === 400) {
        toast("Bad request", {
          description: "Please check your request and try again",
        });
        return Promise.reject(error);
      }
      if (error.response.status === 401) {
        toast("Unauthorized", {
          description: "Please login to continue",
        });
        return Promise.reject(error);
      }
      if (error.response.status === 403) {
        toast("Forbidden", {
          description: "You don't have permission to access this resource",
        });
        return Promise.reject(error);
      }
      if (error.response.status === 404) {
        toast("Not found", {
          description: "The resource you are looking for does not exist",
        });
        return Promise.reject(error);
      }
      if (error.response.status === 410) {
        toast("Code expired", {
          description: "Please request a new code",
        });
        return Promise.reject(error);
      }
      if (error.response.status === 429) {
        toast("Too many requests", {
          description: "Please try again later",
        });
        return Promise.reject(error);
      }
      if (error.response.status === 500) {
        toast("Internal server error", {
          description: "Something went wrong on our end",
        });
        return Promise.reject(error);
      }
      toast("Something went wrong", {
        description: "Something went wrong!",
      });
      return Promise.reject(error);
    }
    toast("Something went wrong", {
      description: "An unknown error occurred",
    });
    return Promise.reject(error);
  }
);

export const useAuthStore = defineStore("auth", {
  state: () => ({
    currentUser: null,
    isAuthDialogOpen: false,
    authDialogMode: "login",
    isResetPasswordDialogOpen: false,
    codeAccepted: false,
  }),

  actions: {
    async login(email, password) {
      // we check if the email is valid
      if (!ve(email)) {
        toast("Invalid email", {
          description: "Please enter a valid email",
        });
        throw new Error("Invalid email");
      }
      // we check if the password is valid
      if (!vp(password)) {
        toast("Invalid password", {
          description: "Password must be at least 6 characters",
        });
        throw new Error("Invalid password");
      }
      try {
        await ServerClient.post("/login", {
          email: email,
          password: password,
        });
        await this.fetchUser();
      } catch (error) {
        throw new Error(error);
      }
    },

    async fetchUser() {
      try {
        const response = await ServerClient.get("/fetchUser");
        this.currentUser = response.data.user;
      } catch (error) {
        throw new Error(error);
      }
    },

    async signup(name, userName, email, password) {
      try {
        // we check if the email is valid
        if (!ve(email)) {
          toast("Invalid email", {
            description: "Please enter a valid email",
          });
          throw new Error("Invalid email");
        }
        // we check if the password is valid
        if (!vp(password)) {
          toast("Invalid password", {
            description: "Password must be at least 6 characters",
          });
          throw new Error("Invalid password");
        }

        // we check if the name is valid
        if (!en(name)) {
          toast("Invalid name", {
            description: "Please enter a valid name",
          });
          throw new Error("Invalid name");
        }
        await ServerClient.post("/signUp", {
          email: email,
          password: password,
          userName: vn(userName),
          name: vn(name),
        });
        await this.fetchUser();
      } catch (error) {
        throw new Error(error);
      }
    },

    async sendResetPasswordEmail(email) {
      try {
        // validate email
        if (!ve(email)) {
          toast("Invalid email", {
            description: "Please enter a valid email",
          });
          throw new Error("Invalid email");
        }
        await ServerClient.post("/resetPasswordRequest", {
          email: email,
        });
      } catch (error) {
        throw new Error(error);
      }
    },

    async checkCode(code) {
      try {
        await ServerClient.post("/confirmResetPasswordCode", {
          code: code,
        });
        this.codeAccepted = true;
      } catch (error) {
        this.codeAccepted = false;
        throw new Error(error);
      }
    },

    async logout() {
      await ServerClient.get("/logout");
      this.currentUser = null;
    },

    openAuthDialog(mode) {
      this.authDialogMode = mode;
      this.isAuthDialogOpen = true;
    },

    openResetPasswordDialog() {
      this.isResetPasswordDialogOpen = true;
    },

    closeAuthDialog() {
      this.isAuthDialogOpen = false;
    },

    closeResetPasswordDialog() {
      this.isResetPasswordDialogOpen = false;
    },
  },
});
