import React, { useState, useEffect } from "react";
import { motion } from "framer-motion";

export default function GreenBeanAccs() {
  const [showLogin, setShowLogin] = useState(false);
  const [showDashboard, setShowDashboard] = useState(false);
  const [activeTab, setActiveTab] = useState("home");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [activePlan, setActivePlan] = useState(null);
  const [lastGenerated, setLastGenerated] = useState(null);
  const [generatedAccount, setGeneratedAccount] = useState(null);

  // Persistent login state
  useEffect(() => {
    const savedLogin = localStorage.getItem("gbaccs_user");
    if (savedLogin) setShowDashboard(true);
  }, []);

  const robloxAccounts = [
    { username: "GreenyAlt_01", password: "bean1234" },
    { username: "RBXGreenBean", password: "coolalt567" },
    { username: "BeanedUp2025", password: "robloxrocks" },
    { username: "AccMaker300", password: "freealt999" },
    { username: "SlayerBean", password: "securePass12" },
  ];

  const plans = [
    { id: "free", name: "Free", price: "$0", features: ["1 free account every 4 hours", "Community support"] },
    { id: "pro", name: "Pro", price: "$9.99/mo", features: ["Priority accounts", "Faster delivery", "Premium support"] },
    { id: "elite", name: "Elite", price: "$24.99/mo", features: ["Bulk access", "API access", "Dedicated support"] },
  ];

  function handleLogin(e) {
    e.preventDefault();
    alert(`Logging in ${email} — demo only.`);
    setShowLogin(false);
    setShowDashboard(true);
    localStorage.setItem("gbaccs_user", email);
  }

  function handleGoogleLogin() {
    alert("Google login clicked — integrate Google OAuth here.");
    setShowLogin(false);
    setShowDashboard(true);
    localStorage.setItem("gbaccs_user", "google_user");
  }

  function handleLogout() {
    localStorage.removeItem("gbaccs_user");
    setShowDashboard(false);
  }

  function handleGetStarted() {
    setActivePlan("free");
    window.location.hash = "#free-generator";
  }

  function handleGenerateAccount() {
    const now = Date.now();
    if (lastGenerated && now - lastGenerated < 4 * 60 * 60 * 1000) {
      const remaining = Math.ceil((4 * 60 * 60 * 1000 - (now - lastGenerated)) / 60000);
      alert(`Please wait ${remaining} minutes before generating another account.`);
      return;
    }

    const randomAcc = robloxAccounts[Math.floor(Math.random() * robloxAccounts.length)];
    setGeneratedAccount(randomAcc);
    setLastGenerated(now);
  }

  function scrollToPricing() {
    document.getElementById("pricing")?.scrollIntoView({ behavior: "smooth" });
  }

  if (showDashboard) {
    return (
      <div className="min-h-screen bg-gradient-to-b from-green-900 via-emerald-800 to-green-900 text-emerald-100 overflow-x-hidden">
        <motion.header initial={{ y: -50, opacity: 0 }} animate={{ y: 0, opacity: 1 }} transition={{ duration: 0.6 }} className="max-w-6xl mx-auto px-6 py-6 flex items-center justify-between">
          <h1 className="text-lg font-semibold text-lime-400">GreenBeanAccs Dashboard</h1>
          <button onClick={handleLogout} className="bg-lime-500 px-4 py-2 rounded text-green-950">Logout</button>
        </motion.header>

        <main className="max-w-6xl mx-auto px-6">
          <div className="flex gap-4 mb-6">
            <motion.button whileHover={{ scale: 1.1 }} onClick={() => setActiveTab("home")} className={`px-4 py-2 rounded-md ${activeTab === "home" ? 'bg-lime-500 text-green-950' : 'bg-emerald-800 text-emerald-300'}`}>Home</motion.button>
            <motion.button whileHover={{ scale: 1.1 }} onClick={() => setActiveTab("settings")} className={`px-4 py-2 rounded-md ${activeTab === "settings" ? 'bg-lime-500 text-green-950' : 'bg-emerald-800 text-emerald-300'}`}>Settings</motion.button>
            <motion.button whileHover={{ scale: 1.1 }} onClick={() => setActiveTab("plans")} className={`px-4 py-2 rounded-md ${activeTab === "plans" ? 'bg-lime-500 text-green-950' : 'bg-emerald-800 text-emerald-300'}`}>Plans</motion.button>
          </div>

          {activeTab === "home" && (
            <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="bg-emerald-800 p-6 rounded-xl text-center">
              <h2 className="text-2xl font-bold text-lime-400 mb-4">Generate Free Roblox Account</h2>
              <p className="text-emerald-300 mb-6">Click the button below to generate a free Roblox account every 4 hours.</p>
              <motion.button whileHover={{ scale: 1.1 }} whileTap={{ scale: 0.95 }} onClick={handleGenerateAccount} className="bg-lime-500 hover:bg-lime-600 text-green-950 px-6 py-3 rounded-md font-semibold">Generate</motion.button>

              {generatedAccount && (
                <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="mt-6 bg-black/30 p-4 rounded-md inline-block">
                  <h3 className="text-lime-400 text-lg font-semibold mb-2">Your Account:</h3>
                  <p className="text-emerald-200">Username: <span className="font-bold">{generatedAccount.username}</span></p>
                  <p className="text-emerald-200">Password: <span className="font-bold">{generatedAccount.password}</span></p>
                </motion.div>
              )}
            </motion.div>
          )}

          {activeTab === "settings" && (
            <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="bg-emerald-800 p-6 rounded-xl">
              <h2 className="text-2xl font-bold text-lime-400 mb-4">Settings</h2>
              <p className="text-emerald-300">Adjust your account preferences (demo only).</p>
              <div className="mt-4 text-emerald-200">Logged in as: <span className="font-bold">{localStorage.getItem("gbaccs_user")}</span></div>
            </motion.div>
          )}

          {activeTab === "plans" && (
            <motion.section id="plans" initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="mt-8 text-center">
              <h3 className="text-3xl font-extrabold text-lime-400 mb-8 drop-shadow">Choose Your Plan</h3>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {plans.map((plan, i) => (
                  <motion.div key={plan.id} initial={{ y: 50, opacity: 0 }} whileInView={{ y: 0, opacity: 1 }} transition={{ delay: i * 0.2 }} className="bg-emerald-800 rounded-xl p-6 shadow-lg hover:shadow-lime-500/30 hover:scale-105 transform transition">
                    <h4 className="text-2xl font-semibold text-lime-400">{plan.name}</h4>
                    <div className="text-3xl font-bold mt-2 mb-4">{plan.price}</div>
                    <ul className="space-y-2 text-emerald-300">
                      {plan.features.map((f, idx) => (
                        <li key={idx}>• {f}</li>
                      ))}
                    </ul>
                    <motion.button whileHover={{ scale: 1.05 }} whileTap={{ scale: 0.95 }} onClick={() => setActivePlan(plan.id)} className="mt-6 bg-lime-500 hover:bg-lime-600 text-green-950 px-4 py-2 rounded-md font-medium w-full">
                      Select
                    </motion.button>
                  </motion.div>
                ))}
              </div>
            </motion.section>
          )}
        </main>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-b from-green-900 via-emerald-800 to-green-900 text-emerald-100 overflow-x-hidden">
      <motion.header initial={{ y: -50, opacity: 0 }} animate={{ y: 0, opacity: 1 }} transition={{ duration: 0.6 }} className="max-w-6xl mx-auto px-6 py-6 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <motion.div whileHover={{ rotate: 10, scale: 1.1 }} className="w-10 h-10 bg-gradient-to-tr from-green-400 to-lime-500 rounded-lg flex items-center justify-center font-extrabold shadow-lg">
            GB
          </motion.div>
          <div>
            <h1 className="text-lg font-semibold">GreenBean<span className="text-lime-400">Accs</span></h1>
            <p className="text-xs text-emerald-400">Roblox Alts Generator & Marketplace</p>
          </div>
        </div>

        <nav className="hidden md:flex items-center gap-6 text-sm text-emerald-300">
          <motion.button whileHover={{ scale: 1.1 }} className="hover:text-white" onClick={scrollToPricing}>Pricing</motion.button>
          <motion.button whileHover={{ scale: 1.1 }} whileTap={{ scale: 0.95 }} onClick={() => setShowLogin(true)} className="ml-2 bg-lime-500 hover:bg-lime-600 px-4 py-2 rounded-md text-sm font-medium text-green-950">Login</motion.button>
        </nav>
      </motion.header>

      <main className="max-w-6xl mx-auto px-6 text-center mt-20">
        <motion.h2 initial={{ opacity: 0, y: -30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }} className="text-5xl font-extrabold text-lime-400 drop-shadow-lg">Welcome to GreenBeanAccs</motion.h2>
        <motion.p initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3, duration: 0.8 }} className="mt-4 text-emerald-300 max-w-2xl mx-auto">Get fresh, working Roblox accounts in seconds — powered by smooth animations and real account generation!</motion.p>

        <div className="mt-8 flex justify-center gap-4">
          <motion.button whileHover={{ scale: 1.1 }} onClick={handleGetStarted} className="bg-lime-500 text-green-950 px-6 py-3 rounded-md font-semibold shadow">Get Started</motion.button>
          <motion.button whileHover={{ scale: 1.1 }} onClick={scrollToPricing} className="border border-lime-400 text-lime-400 px-6 py-3 rounded-md font-semibold">View Plans</motion.button>
        </div>
      </main>

      {showLogin && (
        <div className="fixed inset-0 bg-black/60 flex items-center justify-center p-6">
          <motion.div initial={{ scale: 0.8, opacity: 0 }} animate={{ scale: 1, opacity: 1 }} className="bg-emerald-900 rounded-xl w-full max-w-md p-6">
            <div className="flex items-center justify-between">
              <h4 className="text-lg font-semibold text-lime-400">Sign in</h4>
              <button onClick={() => setShowLogin(false)} className="text-emerald-400">Close</button>
            </div>

            <div className="mt-4 space-y-4">
              <motion.button whileHover={{ scale: 1.05 }} onClick={handleGoogleLogin} className="w-full bg-lime-500 hover:bg-lime-600 px-4 py-2 rounded text-green-950 font-medium">Continue with Google</motion.button>

              <div className="flex items-center gap-2 text-emerald-500">
                <hr className="flex-1 border-emerald-700" />
                <span className="text-xs">or</span>
                <hr className="flex-1 border-emerald-700" />
              </div>

              <form onSubmit={handleLogin} className="space-y-4">
                <label className="text-sm text-emerald-300">Email</label>
                <input value={email} onChange={(e) => setEmail(e.target.value)} className="w-full bg-black/30 p-2 rounded" />

                <label className="text-sm text-emerald-300">Password</label>
                <input value={password} onChange={(e) => setPassword(e.target.value)} type="password" className="w-full bg-black/30 p-2 rounded" />

                <div className="flex items-center justify-between">
                  <div className="text-xs text-emerald-400">Forgot password?</div>
                  <motion.button whileHover={{ scale: 1.05 }} className="bg-lime-500 px-4 py-2 rounded text-green-950 font-semibold">Sign in</motion.button>
                </div>
              </form>
            </div>
          </motion.div>
        </div>
      )}
    </div>
  );
}
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/greenbeanaccs.git
git push -u origin main
