import {createRouter, createWebHistory} from 'vue-router'
import Layout from "@/layout/Layout";

const routes = [
    {
        path: '/',
        name: 'Layout',
        component: Layout,
        redirect: "/home",
        children: [
            {
                path: 'home',
                name: 'Home',
                component: () => import("@/views/Home"),
            },
        ]
    },
    {
        path: '/login',
        name: 'Login',
        component: () => import("@/views/Login")
    },
    {
        path: '/register',
        name: 'Register',
        component: () => import("@/views/Register")
    },
    {
        path: '/index',
        name: 'Index',
        component: () => import("@/views/Index")
    },
    // {
    //     path: '/cart',
    //     name: 'Cart',
    //     component: () => import("@/views/Cart")
    // },
    {
        path: '/myRecord',
        name: 'MyRecord',
        component: () => import("@/views/MyRecord")
    },
    {
        path: '/recordDetail',
        name: 'RecordDetail',
        component: () => import("@/views/RecordDetail")
    },


]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})

// 在刷新页面的时候重置当前路由
activeRouter()

function activeRouter() {
    const userStr = sessionStorage.getItem("user")
    console.log(userStr )
    if (userStr) {
        const user = JSON.parse(userStr)
        let root = {
            path: '/',
            name: 'Layout',
            component: Layout,
            redirect: "/home",
            children: []
        }
        user.permissions.forEach(p => {
            let obj = {
                path: p.path,
                name: p.name,
                component: () => import("@/views/" + p.name)
            };
            root.children.push(obj)
        })
        if (router) {
            router.addRoute(root)
        }
    }
}

router.beforeEach((to, from, next) => {
    console.log(to.path )
    if (to.path === '/login' || to.path === '/register'|| to.path === '/index') {
        next()
        return
    }
    let user = sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {}
    if (!user.permissions || !user.permissions.length) {
        next('/login')
    } else if (!user.permissions.find(p => p.path === to.path)) {
        next('/login')
    } else {
        next()
    }
})

export default router
