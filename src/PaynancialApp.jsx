import React, { useState, useMemo } from "react";
import {
  LayoutDashboard, FileText, Users, Package, Settings as SettingsIcon,
  Plus, Search, Trash2, Phone, CheckCircle2, Clock, AlertCircle,
  IndianRupee, X, TrendingUp, TrendingDown, Receipt, Building2, Menu,
  Bell, Printer, MoreVertical, ArrowUpRight, ArrowDownRight, FileClock,
} from "lucide-react";
import {
  BarChart, Bar, XAxis, YAxis, ResponsiveContainer, Tooltip, CartesianGrid
} from "recharts";

// Palette pulled from the Paynancial logo mark.
const TEAL = "#0E9C93";
const TEAL_DARK = "#0B6B64";
const TEAL_DEEP = "#083F3C";
const TEAL_TINT = "#E4F5F3";
const ORANGE = "#F4611E";
const ORANGE_DARK = "#D94E10";
const ORANGE_TINT = "#FDE9DF";
const INK = "#0F2926";
const MUTED = "#5C7472";
const BG = "#F2F8F7";
const LINE = "#DCEAE8";
const GOLD = "#B8862E";
const GOLD_TINT = "#F6EDD9";

const STATES = ["Jharkhand", "Maharashtra", "Delhi", "Karnataka", "Gujarat", "West Bengal", "Tamil Nadu", "Uttar Pradesh"];
const GST_SLABS = [0, 5, 12, 18, 28];
const BUSINESS_STATE = "Jharkhand";
const FY = "25-26";

const fmt = (n) => "₹" + Number(n || 0).toLocaleString("en-IN", { maximumFractionDigits: 2 });

const seedParties = [
  { id: "p1", name: "Ranchi Steel Traders", gstin: "20AACCR1234F1Z5", state: "Jharkhand", phone: "9832011223" },
  { id: "p2", name: "Bandra Textiles Pvt Ltd", gstin: "27AAECB5678H1Z2", state: "Maharashtra", phone: "9820098200" },
  { id: "p3", name: "Karol Bagh Electronics", gstin: "07AAFCK9988L1Z7", state: "Delhi", phone: "9911223344" },
];

const seedInvoices = [
  { id: "i1", no: `PYN/${FY}/0001`, party: seedParties[0], date: "2026-08-04", items: [{ desc: "Mild Steel Rods (10mm)", hsn: "7213", qty: 40, rate: 620, gst: 18 }], status: "Paid" },
  { id: "i2", no: `PYN/${FY}/0002`, party: seedParties[1], date: "2026-08-11", items: [{ desc: "Cotton Fabric Roll", hsn: "5208", qty: 15, rate: 1450, gst: 5 }], status: "Pending" },
  { id: "i3", no: `PYN/${FY}/0003`, party: seedParties[2], date: "2026-08-18", items: [{ desc: "LED Panel Light 24W", hsn: "8539", qty: 60, rate: 340, gst: 12 }], status: "Overdue" },
  { id: "i4", no: `PYN/${FY}/0004`, party: seedParties[0], date: "2026-08-22", items: [{ desc: "Welding Electrodes", hsn: "8311", qty: 25, rate: 210, gst: 18 }], status: "Paid" },
];

const monthlyTrend = [
  { m: "Mar", sales: 182000 }, { m: "Apr", sales: 214000 }, { m: "May", sales: 196000 },
  { m: "Jun", sales: 241000 }, { m: "Jul", sales: 268000 }, { m: "Aug", sales: 233000 },
];

function calcInvoice(inv) {
  let taxable = 0, gstTotal = 0;
  inv.items.forEach((it) => {
    const amt = it.qty * it.rate;
    taxable += amt;
    gstTotal += amt * (it.gst / 100);
  });
  const interState = inv.party.state !== BUSINESS_STATE;
  return {
    taxable,
    cgst: interState ? 0 : gstTotal / 2,
    sgst: interState ? 0 : gstTotal / 2,
    igst: interState ? gstTotal : 0,
    gstTotal,
    grand: taxable + gstTotal,
    interState,
  };
}

const statusStyle = {
  Paid: { bg: TEAL_TINT, fg: TEAL_DARK, icon: CheckCircle2 },
  Pending: { bg: GOLD_TINT, fg: GOLD, icon: Clock },
  Overdue: { bg: ORANGE_TINT, fg: ORANGE_DARK, icon: AlertCircle },
};

function StatusBadge({ status }) {
  const s = statusStyle[status];
  const Icon = s.icon;
  return (
    <span style={{ background: s.bg, color: s.fg }} className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-semibold">
      <Icon size={12} strokeWidth={2.5} />
      {status}
    </span>
  );
}

// Logo mark: a teal "P" flag with a notched white checkmark, echoing the brand logo.
function LogoMark({ size = 34 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 40 40" fill="none">
      <path
        d="M8 4 C8 4 24 4 27 12 C29.5 18.5 22 22.5 15 23.2 L15 36 L8 36 Z"
        fill={TEAL}
      />
      <path
        d="M9.5 17.5 L14 22 L23 12.5"
        stroke="white"
        strokeWidth="3.4"
        strokeLinecap="round"
        strokeLinejoin="round"
        fill="none"
      />
    </svg>
  );
}

function Wordmark({ dark, size = 19 }) {
  return (
    <span style={{ fontFamily: "'Fraunces', serif", fontSize: size, fontWeight: 600 }}>
      <span style={{ color: dark ? "#EAF7F5" : TEAL }}>Pay</span>
      <span style={{ color: ORANGE }}>nancial</span>
    </span>
  );
}

function StatCard({ label, value, sub, accent, icon: Icon, trend }) {
  return (
    <div className="rounded-2xl p-4 flex-1 min-w-[190px]" style={{ background: "white", border: `1px solid ${LINE}` }}>
      <div className="flex items-start justify-between">
        <p className="text-xs font-medium tracking-wide uppercase" style={{ color: MUTED }}>{label}</p>
        {Icon && (
          <div className="w-8 h-8 rounded-full flex items-center justify-center shrink-0" style={{ background: (accent || TEAL) + "1A" }}>
            <Icon size={15} color={accent || TEAL} strokeWidth={2.5} />
          </div>
        )}
      </div>
      <p className="mt-1 font-semibold" style={{ fontFamily: "'IBM Plex Mono', monospace", fontSize: 24, color: INK }}>{value}</p>
      {sub && <p className="text-xs mt-1" style={{ color: MUTED }}>{sub}</p>}
      {trend && (
        <p className="text-xs mt-2 inline-flex items-center gap-1 font-medium" style={{ color: trend.up ? TEAL_DARK : ORANGE_DARK }}>
          {trend.up ? <ArrowUpRight size={13} /> : <ArrowDownRight size={13} />}
          {trend.label}
        </p>
      )}
    </div>
  );
}

function Sidebar({ view, setView, mobileOpen, setMobileOpen }) {
  const groups = [
    {
      label: "Overview",
      items: [{ id: "dashboard", label: "Dashboard", icon: LayoutDashboard }],
    },
    {
      label: "Sales",
      items: [
        { id: "invoices", label: "Invoices", icon: FileText },
        { id: "create", label: "New invoice", icon: Plus },
      ],
    },
    {
      label: "Business",
      items: [
        { id: "parties", label: "Parties", icon: Users },
        { id: "items", label: "Items", icon: Package },
      ],
    },
    {
      label: "General",
      items: [{ id: "settings", label: "Settings", icon: SettingsIcon }],
    },
  ];

  return (
    <div
      className={`${mobileOpen ? "flex" : "hidden"} md:flex flex-col fixed md:static inset-0 z-20 md:z-auto`}
      style={{
        background: `linear-gradient(180deg, ${TEAL_DARK} 0%, ${TEAL_DEEP} 100%)`,
        width: 240,
        minHeight: "100%",
      }}
    >
      <div className="flex items-center justify-between px-5 pt-6 pb-4">
        <div className="flex items-center gap-2">
          <LogoMark size={32} />
          <Wordmark dark size={18} />
        </div>
        <button className="md:hidden" onClick={() => setMobileOpen(false)}>
          <X size={18} color={TEAL_TINT} />
        </button>
      </div>

      <div className="px-4 pb-3">
        <div
          className="flex items-center gap-2 px-3 py-2 rounded-lg text-xs"
          style={{ background: "rgba(255,255,255,0.08)", color: "rgba(228,245,243,0.55)" }}
        >
          <Search size={13} />
          Search (⌘K)
        </div>
      </div>

      <nav className="flex-1 px-3 mt-1 space-y-4 overflow-y-auto">
        {groups.map((g) => (
          <div key={g.label}>
            <p className="px-3 mb-1 text-[10px] font-semibold tracking-widest uppercase" style={{ color: "rgba(228,245,243,0.35)" }}>
              {g.label}
            </p>
            <div className="space-y-1">
              {g.items.map((it) => {
                const Icon = it.icon;
                const active = view === it.id;
                return (
                  <button
                    key={it.id}
                    onClick={() => { setView(it.id); setMobileOpen(false); }}
                    className="w-full flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm transition-colors"
                    style={{
                      background: active ? ORANGE : "transparent",
                      color: active ? "white" : "rgba(228,245,243,0.7)",
                      fontWeight: active ? 600 : 500,
                    }}
                  >
                    <Icon size={16} />
                    {it.label}
                  </button>
                );
              })}
            </div>
          </div>
        ))}
      </nav>

      <div className="px-4 pb-4 pt-2">
        <div
          className="rounded-xl px-3 py-3 flex items-center gap-2.5"
          style={{ background: "rgba(255,255,255,0.07)" }}
        >
          <div className="w-8 h-8 rounded-lg flex items-center justify-center shrink-0 text-xs font-bold" style={{ background: ORANGE, color: "white" }}>
            PD
          </div>
          <div className="min-w-0">
            <p className="text-xs font-medium truncate" style={{ color: "#EAF7F5" }}>Paynancial Demo Ent.</p>
            <p className="text-[10px]" style={{ color: "rgba(228,245,243,0.5)" }}>FY {FY} · v0.0.1</p>
          </div>
        </div>
      </div>
    </div>
  );
}

function TopBar({ setMobileOpen, setView }) {
  return (
    <div className="hidden md:block" style={{ background: "white", borderBottom: `1px solid ${LINE}` }}>
      <div className="flex items-center justify-between gap-3 px-6 py-2 text-xs" style={{ background: BG, color: MUTED, borderBottom: `1px solid ${LINE}` }}>
        <span className="flex items-center gap-1.5">
          <Phone size={12} color={ORANGE} />
          Customer support: <span style={{ color: INK, fontWeight: 500 }}>070 6581 9819</span>
        </span>
        <span className="font-medium" style={{ color: TEAL_DARK }}>Mon–Sat, 9:30 AM – 7:00 PM IST</span>
      </div>
      <div className="flex items-center justify-between gap-4 px-6 py-3">
        <div className="relative flex-1 max-w-md">
          <Search size={14} className="absolute left-3 top-1/2 -translate-y-1/2" color={MUTED} />
          <input
            placeholder="Search invoices, parties, items…"
            className="pl-8 pr-3 py-2 rounded-lg text-sm outline-none w-full"
            style={{ border: `1px solid ${LINE}`, background: BG }}
          />
        </div>
        <div className="flex items-center gap-2">
          <button
            onClick={() => setView("create")}
            className="flex items-center gap-1.5 px-3.5 py-2 rounded-lg text-sm font-semibold"
            style={{ background: ORANGE, color: "white" }}
          >
            <Plus size={15} /> New invoice
          </button>
          <button
            onClick={() => setView("parties")}
            className="flex items-center gap-1.5 px-3.5 py-2 rounded-lg text-sm font-semibold"
            style={{ background: TEAL_TINT, color: TEAL_DARK }}
          >
            <Plus size={15} /> Add party
          </button>
          <div className="w-px h-6" style={{ background: LINE }} />
          <button className="p-2 rounded-lg" style={{ color: MUTED }}><Bell size={17} /></button>
          <button className="p-2 rounded-lg" style={{ color: MUTED }}><Printer size={17} /></button>
          <button className="p-2 rounded-lg" style={{ color: MUTED }}><MoreVertical size={17} /></button>
        </div>
      </div>
    </div>
  );
}

function QuickActionsCard({ setView }) {
  const actions = [
    { id: "create", label: "New invoice", icon: Plus },
    { id: "parties", label: "Add party", icon: Users },
    { id: "invoices", label: "All invoices", icon: FileText },
    { id: "settings", label: "GST profile", icon: Building2 },
  ];
  return (
    <div className="rounded-2xl p-4" style={{ background: "white", border: `1px solid ${LINE}` }}>
      <h3 className="font-semibold text-sm mb-3" style={{ color: INK }}>Quick actions</h3>
      <div className="space-y-1">
        {actions.map((a) => {
          const Icon = a.icon;
          return (
            <button
              key={a.id}
              onClick={() => setView(a.id)}
              className="w-full flex items-center justify-between px-3 py-2.5 rounded-lg text-sm"
              style={{ color: INK, background: BG }}
            >
              <span className="flex items-center gap-2.5"><Icon size={15} color={TEAL} /> {a.label}</span>
              <span style={{ color: MUTED }}>›</span>
            </button>
          );
        })}
      </div>
    </div>
  );
}

function SupportWidget() {
  return (
    <div className="rounded-2xl p-4" style={{ background: TEAL_DARK, color: "white" }}>
      <div className="flex items-center gap-2 mb-1.5">
        <Phone size={15} color={ORANGE} />
        <h3 className="font-semibold text-sm">Need a hand?</h3>
      </div>
      <p className="text-xs" style={{ color: "rgba(255,255,255,0.75)" }}>GST filing, invoices, or account help — talk to our team.</p>
      <p className="mt-3 text-lg font-semibold" style={{ fontFamily: "'IBM Plex Mono', monospace", color: "white" }}>070 6581 9819</p>
      <button className="mt-3 w-full py-2 rounded-lg text-xs font-semibold" style={{ background: ORANGE, color: "white" }}>
        Get instant support
      </button>
    </div>
  );
}

function GstReminderWidget({ setView }) {
  return (
    <div className="rounded-2xl p-4" style={{ background: "white", border: `1px solid ${LINE}` }}>
      <div className="flex items-center gap-2 mb-1.5">
        <FileClock size={15} color={ORANGE} />
        <h3 className="font-semibold text-sm" style={{ color: INK }}>GSTR-1 due soon</h3>
      </div>
      <p className="text-xs" style={{ color: MUTED }}>File before the 11th to stay clear of late fees this cycle.</p>
      <button
        onClick={() => setView("settings")}
        className="mt-3 text-xs font-semibold flex items-center gap-1"
        style={{ color: TEAL_DARK }}
      >
        View business profile <span>→</span>
      </button>
    </div>
  );
}

function Dashboard({ invoices, setView }) {
  const totals = useMemo(() => {
    let sales = 0, gst = 0, pending = 0;
    invoices.forEach((inv) => {
      const c = calcInvoice(inv);
      sales += c.grand;
      gst += c.gstTotal;
      if (inv.status !== "Paid") pending += c.grand;
    });
    return { sales, gst, pending };
  }, [invoices]);

  return (
    <div className="grid xl:grid-cols-[1fr_280px] gap-5 items-start">
      <div className="space-y-5 min-w-0">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <div>
            <h1 style={{ fontFamily: "'Fraunces', serif", fontSize: 26, color: INK, fontWeight: 600 }}>Dashboard</h1>
            <p className="text-sm mt-0.5" style={{ color: MUTED }}>FY {FY} · Business state: {BUSINESS_STATE}</p>
          </div>
          <button
            onClick={() => setView("create")}
            className="md:hidden flex items-center gap-2 px-4 py-2.5 rounded-lg text-sm font-semibold"
            style={{ background: ORANGE, color: "white" }}
          >
            <Plus size={16} /> New invoice
          </button>
        </div>

        <div className="flex flex-wrap gap-3">
          <StatCard label="Total sales" value={fmt(totals.sales)} sub={`${invoices.length} invoices`} accent={TEAL} icon={TrendingUp} trend={{ up: true, label: "12.4% vs last month" }} />
          <StatCard label="Pending amount" value={fmt(totals.pending)} sub="Across unpaid invoices" accent={ORANGE_DARK} icon={TrendingDown} trend={{ up: false, label: "Follow up needed" }} />
          <StatCard label="GST collected" value={fmt(totals.gst)} sub="CGST + SGST + IGST" accent={GOLD} icon={Receipt} />
          <StatCard label="Active parties" value={new Set(invoices.map((i) => i.party.id)).size} sub="Buyers this year" accent={TEAL} icon={Users} />
        </div>

        <div className="rounded-2xl p-5" style={{ background: "white", border: `1px solid ${LINE}` }}>
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-2">
              <TrendingUp size={16} color={ORANGE} />
              <h3 className="font-semibold text-sm" style={{ color: INK }}>Sales trend, last 6 months</h3>
            </div>
            <span className="text-xs font-medium px-2.5 py-1 rounded-full" style={{ background: TEAL_TINT, color: TEAL_DARK }}>This month</span>
          </div>
          <div style={{ height: 220 }}>
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={monthlyTrend} barSize={28}>
                <CartesianGrid vertical={false} stroke={LINE} />
                <XAxis dataKey="m" tick={{ fontSize: 12, fill: MUTED }} axisLine={false} tickLine={false} />
                <YAxis tick={{ fontSize: 11, fill: MUTED }} axisLine={false} tickLine={false} tickFormatter={(v) => `${v / 1000}k`} />
                <Tooltip formatter={(v) => fmt(v)} contentStyle={{ fontSize: 12, borderRadius: 8, border: `1px solid ${LINE}` }} />
                <Bar dataKey="sales" fill={TEAL} radius={[4, 4, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>

        <div className="rounded-2xl p-5" style={{ background: "white", border: `1px solid ${LINE}` }}>
          <h3 className="font-semibold text-sm mb-3" style={{ color: INK }}>Recent invoices</h3>
          <div className="divide-y" style={{ borderColor: LINE }}>
            {invoices.slice().reverse().slice(0, 4).map((inv) => {
              const c = calcInvoice(inv);
              return (
                <div key={inv.id} className="flex items-center justify-between py-3" style={{ borderColor: LINE }}>
                  <div>
                    <p className="text-sm font-medium" style={{ color: INK, fontFamily: "'IBM Plex Mono', monospace" }}>{inv.no}</p>
                    <p className="text-xs mt-0.5" style={{ color: MUTED }}>{inv.party.name} · {inv.date}</p>
                  </div>
                  <div className="flex items-center gap-3">
                    <span className="text-sm font-semibold" style={{ color: INK }}>{fmt(c.grand)}</span>
                    <StatusBadge status={inv.status} />
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>

      <div className="space-y-4">
        <QuickActionsCard setView={setView} />
        <SupportWidget />
        <GstReminderWidget setView={setView} />
      </div>
    </div>
  );
}

function InvoiceList({ invoices, setInvoices }) {
  const [q, setQ] = useState("");
  const filtered = invoices.filter((i) => i.party.name.toLowerCase().includes(q.toLowerCase()) || i.no.toLowerCase().includes(q.toLowerCase()));

  const cycleStatus = (id) => {
    const order = ["Pending", "Paid", "Overdue"];
    setInvoices((prev) => prev.map((inv) => inv.id === id ? { ...inv, status: order[(order.indexOf(inv.status) + 1) % order.length] } : inv));
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between gap-3">
        <h1 style={{ fontFamily: "'Fraunces', serif", fontSize: 24, color: INK, fontWeight: 600 }}>Invoices</h1>
        <div className="relative">
          <Search size={14} className="absolute left-3 top-1/2 -translate-y-1/2" color={MUTED} />
          <input
            value={q} onChange={(e) => setQ(e.target.value)} placeholder="Search party or invoice no."
            className="pl-8 pr-3 py-2 rounded-lg text-sm outline-none"
            style={{ border: `1px solid ${LINE}`, background: "white", width: 220 }}
          />
        </div>
      </div>

      <div className="rounded-2xl overflow-hidden" style={{ border: `1px solid ${LINE}`, background: "white" }}>
        <table className="w-full text-sm" style={{ tableLayout: "fixed" }}>
          <thead>
            <tr style={{ background: TEAL_TINT, color: TEAL_DARK }}>
              <th className="text-left font-medium px-4 py-3" style={{ width: "22%" }}>Invoice</th>
              <th className="text-left font-medium px-4 py-3" style={{ width: "28%" }}>Party</th>
              <th className="text-left font-medium px-4 py-3" style={{ width: "15%" }}>Date</th>
              <th className="text-right font-medium px-4 py-3" style={{ width: "17%" }}>Amount</th>
              <th className="text-center font-medium px-4 py-3" style={{ width: "18%" }}>Status</th>
            </tr>
          </thead>
          <tbody>
            {filtered.map((inv) => {
              const c = calcInvoice(inv);
              return (
                <tr key={inv.id} style={{ borderTop: `1px solid ${LINE}` }}>
                  <td className="px-4 py-3 font-medium" style={{ color: INK, fontFamily: "'IBM Plex Mono', monospace" }}>{inv.no}</td>
                  <td className="px-4 py-3" style={{ color: INK }}>{inv.party.name}</td>
                  <td className="px-4 py-3" style={{ color: MUTED }}>{inv.date}</td>
                  <td className="px-4 py-3 text-right font-semibold" style={{ color: INK }}>{fmt(c.grand)}</td>
                  <td className="px-4 py-3 text-center">
                    <button onClick={() => cycleStatus(inv.id)}><StatusBadge status={inv.status} /></button>
                  </td>
                </tr>
              );
            })}
            {filtered.length === 0 && (
              <tr><td colSpan={5} className="px-4 py-8 text-center text-sm" style={{ color: MUTED }}>No invoices match your search.</td></tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}

function InvoiceForm({ parties, invoices, setInvoices, setView }) {
  const [partyId, setPartyId] = useState(parties[0].id);
  const [date, setDate] = useState("2026-08-26");
  const [rows, setRows] = useState([{ desc: "", hsn: "", qty: 1, rate: 0, gst: 18 }]);

  const party = parties.find((p) => p.id === partyId);
  const draft = { party, items: rows.map((r) => ({ ...r, qty: Number(r.qty) || 0, rate: Number(r.rate) || 0 })) };
  const c = calcInvoice(draft);
  const nextNo = `PYN/${FY}/${String(invoices.length + 1).padStart(4, "0")}`;

  const updateRow = (idx, key, val) => setRows((prev) => prev.map((r, i) => i === idx ? { ...r, [key]: val } : r));
  const addRow = () => setRows((prev) => [...prev, { desc: "", hsn: "", qty: 1, rate: 0, gst: 18 }]);
  const removeRow = (idx) => setRows((prev) => prev.length > 1 ? prev.filter((_, i) => i !== idx) : prev);

  const save = () => {
    const cleanRows = rows.filter((r) => r.desc.trim() !== "");
    if (cleanRows.length === 0 || !party) return;
    setInvoices((prev) => [...prev, { id: "i" + Date.now(), no: nextNo, party, date, items: cleanRows.map((r) => ({ ...r, qty: Number(r.qty) || 0, rate: Number(r.rate) || 0 })), status: "Pending" }]);
    setView("invoices");
  };

  return (
    <div className="grid md:grid-cols-[1.4fr_1fr] gap-5">
      <div className="space-y-4">
        <h1 style={{ fontFamily: "'Fraunces', serif", fontSize: 24, color: INK, fontWeight: 600 }}>New invoice</h1>

        <div className="rounded-2xl p-4 space-y-3" style={{ background: "white", border: `1px solid ${LINE}` }}>
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="text-xs font-medium" style={{ color: MUTED }}>Bill to</label>
              <select value={partyId} onChange={(e) => setPartyId(e.target.value)} className="mt-1 w-full px-3 py-2 rounded-lg text-sm" style={{ border: `1px solid ${LINE}` }}>
                {parties.map((p) => <option key={p.id} value={p.id}>{p.name} · {p.state}</option>)}
              </select>
            </div>
            <div>
              <label className="text-xs font-medium" style={{ color: MUTED }}>Invoice date</label>
              <input type="date" value={date} onChange={(e) => setDate(e.target.value)} className="mt-1 w-full px-3 py-2 rounded-lg text-sm" style={{ border: `1px solid ${LINE}` }} />
            </div>
          </div>
          <p className="text-xs" style={{ color: c.interState ? ORANGE_DARK : TEAL_DARK }}>
            {c.interState ? `Inter-state supply (${BUSINESS_STATE} → ${party.state}) — IGST applies` : `Intra-state supply (${BUSINESS_STATE}) — CGST + SGST applies`}
          </p>
        </div>

        <div className="rounded-2xl p-4" style={{ background: "white", border: `1px solid ${LINE}` }}>
          <p className="text-xs font-medium mb-3" style={{ color: MUTED }}>Line items</p>
          <div className="space-y-2">
            {rows.map((r, idx) => (
              <div key={idx} className="grid items-center gap-2" style={{ gridTemplateColumns: "2fr 0.8fr 0.6fr 0.8fr 0.7fr auto" }}>
                <input placeholder="Item description" value={r.desc} onChange={(e) => updateRow(idx, "desc", e.target.value)} className="px-2 py-2 rounded-lg text-sm" style={{ border: `1px solid ${LINE}` }} />
                <input placeholder="HSN" value={r.hsn} onChange={(e) => updateRow(idx, "hsn", e.target.value)} className="px-2 py-2 rounded-lg text-sm" style={{ border: `1px solid ${LINE}`, fontFamily: "'IBM Plex Mono', monospace" }} />
                <input type="number" min="0" placeholder="Qty" value={r.qty} onChange={(e) => updateRow(idx, "qty", e.target.value)} className="px-2 py-2 rounded-lg text-sm" style={{ border: `1px solid ${LINE}` }} />
                <input type="number" min="0" placeholder="Rate" value={r.rate} onChange={(e) => updateRow(idx, "rate", e.target.value)} className="px-2 py-2 rounded-lg text-sm" style={{ border: `1px solid ${LINE}` }} />
                <select value={r.gst} onChange={(e) => updateRow(idx, "gst", Number(e.target.value))} className="px-2 py-2 rounded-lg text-sm" style={{ border: `1px solid ${LINE}` }}>
                  {GST_SLABS.map((s) => <option key={s} value={s}>{s}%</option>)}
                </select>
                <button onClick={() => removeRow(idx)} className="p-2"><Trash2 size={15} color={ORANGE_DARK} /></button>
              </div>
            ))}
          </div>
          <button onClick={addRow} className="mt-3 flex items-center gap-1.5 text-sm font-medium" style={{ color: ORANGE }}>
            <Plus size={14} /> Add item
          </button>
        </div>

        <button onClick={save} className="w-full py-3 rounded-lg text-sm font-semibold" style={{ background: ORANGE, color: "white" }}>
          Save invoice {nextNo}
        </button>
      </div>

      <div>
        <div className="sticky top-0 rounded-2xl p-5" style={{ background: "white", border: `1px solid ${LINE}`, position: "relative", overflow: "hidden" }}>
          <div className="flex items-start justify-between">
            <div className="flex items-center gap-2">
              <LogoMark size={24} />
              <div>
                <Wordmark size={16} />
                <p className="text-xs" style={{ color: MUTED }}>GST invoice preview</p>
              </div>
            </div>
            <div
              className="text-xs font-bold px-2 py-1 rounded"
              style={{ border: `2px dashed ${ORANGE}`, color: ORANGE_DARK, transform: "rotate(-7deg)", letterSpacing: 0.5 }}
            >
              GST INVOICE
            </div>
          </div>

          <div className="mt-4 text-xs space-y-1" style={{ color: "#3C544F" }}>
            <p><span style={{ color: MUTED }}>No: </span><span style={{ fontFamily: "'IBM Plex Mono', monospace", color: INK }}>{nextNo}</span></p>
            <p><span style={{ color: MUTED }}>Date: </span>{date}</p>
            <p><span style={{ color: MUTED }}>Bill to: </span>{party?.name}</p>
            <p><span style={{ color: MUTED }}>GSTIN: </span><span style={{ fontFamily: "'IBM Plex Mono', monospace" }}>{party?.gstin}</span></p>
          </div>

          <div className="mt-4 space-y-1.5">
            {rows.filter((r) => r.desc).map((r, i) => (
              <div key={i} className="flex justify-between text-xs">
                <span style={{ color: "#3C544F" }}>{r.desc} × {r.qty}</span>
                <span style={{ fontFamily: "'IBM Plex Mono', monospace", color: INK }}>{fmt(r.qty * r.rate)}</span>
              </div>
            ))}
            {rows.filter((r) => r.desc).length === 0 && <p className="text-xs italic" style={{ color: "#9BB0AD" }}>Add items to see the total.</p>}
          </div>

          <div style={{ height: 2, margin: "16px 0", backgroundImage: `repeating-linear-gradient(to right, ${LINE} 0 6px, transparent 6px 12px)` }} />

          <div className="space-y-1 text-xs">
            <div className="flex justify-between"><span style={{ color: MUTED }}>Taxable value</span><span style={{ fontFamily: "'IBM Plex Mono', monospace" }}>{fmt(c.taxable)}</span></div>
            {c.interState ? (
              <div className="flex justify-between"><span style={{ color: MUTED }}>IGST</span><span style={{ fontFamily: "'IBM Plex Mono', monospace" }}>{fmt(c.igst)}</span></div>
            ) : (
              <>
                <div className="flex justify-between"><span style={{ color: MUTED }}>CGST</span><span style={{ fontFamily: "'IBM Plex Mono', monospace" }}>{fmt(c.cgst)}</span></div>
                <div className="flex justify-between"><span style={{ color: MUTED }}>SGST</span><span style={{ fontFamily: "'IBM Plex Mono', monospace" }}>{fmt(c.sgst)}</span></div>
              </>
            )}
          </div>

          <div className="flex justify-between items-baseline mt-3 pt-3" style={{ borderTop: `1px solid ${LINE}` }}>
            <span className="text-sm font-semibold" style={{ color: INK }}>Grand total</span>
            <span style={{ fontFamily: "'IBM Plex Mono', monospace", fontSize: 19, fontWeight: 600, color: ORANGE_DARK }}>{fmt(c.grand)}</span>
          </div>
        </div>
      </div>
    </div>
  );
}

function Parties({ parties, setParties }) {
  const [form, setForm] = useState({ name: "", gstin: "", state: STATES[0], phone: "" });
  const add = () => {
    if (!form.name.trim()) return;
    setParties((prev) => [...prev, { ...form, id: "p" + Date.now() }]);
    setForm({ name: "", gstin: "", state: STATES[0], phone: "" });
  };
  return (
    <div className="space-y-4">
      <h1 style={{ fontFamily: "'Fraunces', serif", fontSize: 24, color: INK, fontWeight: 600 }}>Parties</h1>
      <div className="rounded-2xl p-4" style={{ background: "white", border: `1px solid ${LINE}` }}>
        <p className="text-xs font-medium mb-3" style={{ color: MUTED }}>Add a party</p>
        <div className="grid md:grid-cols-5 gap-2">
          <input placeholder="Business name" value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} className="px-2 py-2 rounded-lg text-sm md:col-span-2" style={{ border: `1px solid ${LINE}` }} />
          <input placeholder="GSTIN" value={form.gstin} onChange={(e) => setForm({ ...form, gstin: e.target.value })} className="px-2 py-2 rounded-lg text-sm" style={{ border: `1px solid ${LINE}`, fontFamily: "'IBM Plex Mono', monospace" }} />
          <select value={form.state} onChange={(e) => setForm({ ...form, state: e.target.value })} className="px-2 py-2 rounded-lg text-sm" style={{ border: `1px solid ${LINE}` }}>
            {STATES.map((s) => <option key={s}>{s}</option>)}
          </select>
          <input placeholder="Phone" value={form.phone} onChange={(e) => setForm({ ...form, phone: e.target.value })} className="px-2 py-2 rounded-lg text-sm" style={{ border: `1px solid ${LINE}` }} />
        </div>
        <button onClick={add} className="mt-3 flex items-center gap-1.5 text-sm font-medium" style={{ color: ORANGE }}><Plus size={14} /> Add party</button>
      </div>
      <div className="rounded-2xl overflow-hidden" style={{ border: `1px solid ${LINE}`, background: "white" }}>
        {parties.map((p) => (
          <div key={p.id} className="flex items-center justify-between px-4 py-3" style={{ borderTop: `1px solid ${LINE}` }}>
            <div className="flex items-center gap-3">
              <div className="w-9 h-9 rounded-full flex items-center justify-center text-xs font-semibold" style={{ background: TEAL_TINT, color: TEAL_DARK }}>
                {p.name.slice(0, 2).toUpperCase()}
              </div>
              <div>
                <p className="text-sm font-medium" style={{ color: INK }}>{p.name}</p>
                <p className="text-xs" style={{ color: MUTED }}>{p.state} · {p.gstin || "GSTIN not set"}</p>
              </div>
            </div>
            <span className="text-xs" style={{ color: MUTED }}>{p.phone}</span>
          </div>
        ))}
      </div>
    </div>
  );
}

function Items() {
  const catalog = [
    { name: "Mild Steel Rods (10mm)", hsn: "7213", gst: 18, unit: "kg" },
    { name: "Cotton Fabric Roll", hsn: "5208", gst: 5, unit: "mtr" },
    { name: "LED Panel Light 24W", hsn: "8539", gst: 12, unit: "pcs" },
    { name: "Welding Electrodes", hsn: "8311", gst: 18, unit: "box" },
    { name: "Packaging Cartons", hsn: "4819", gst: 12, unit: "pcs" },
  ];
  return (
    <div className="space-y-4">
      <h1 style={{ fontFamily: "'Fraunces', serif", fontSize: 24, color: INK, fontWeight: 600 }}>Items</h1>
      <div className="rounded-2xl overflow-hidden" style={{ border: `1px solid ${LINE}`, background: "white" }}>
        <table className="w-full text-sm">
          <thead><tr style={{ background: TEAL_TINT, color: TEAL_DARK }}>
            <th className="text-left font-medium px-4 py-3">Item</th>
            <th className="text-left font-medium px-4 py-3">HSN</th>
            <th className="text-left font-medium px-4 py-3">Unit</th>
            <th className="text-right font-medium px-4 py-3">GST slab</th>
          </tr></thead>
          <tbody>
            {catalog.map((it, i) => (
              <tr key={i} style={{ borderTop: `1px solid ${LINE}` }}>
                <td className="px-4 py-3" style={{ color: INK }}>{it.name}</td>
                <td className="px-4 py-3" style={{ fontFamily: "'IBM Plex Mono', monospace", color: MUTED }}>{it.hsn}</td>
                <td className="px-4 py-3" style={{ color: MUTED }}>{it.unit}</td>
                <td className="px-4 py-3 text-right font-medium" style={{ color: GOLD }}>{it.gst}%</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

function Settings() {
  return (
    <div className="space-y-4 max-w-xl">
      <h1 style={{ fontFamily: "'Fraunces', serif", fontSize: 24, color: INK, fontWeight: 600 }}>Settings</h1>

      <div className="rounded-2xl p-5" style={{ background: "white", border: `1px solid ${LINE}` }}>
        <div className="flex items-center gap-2 mb-3">
          <Building2 size={16} color={ORANGE} />
          <h3 className="font-semibold text-sm" style={{ color: INK }}>Business profile</h3>
        </div>
        <div className="grid grid-cols-2 gap-3 text-sm">
          <div><p className="text-xs" style={{ color: MUTED }}>Business name</p><p style={{ color: INK }}>Paynancial Demo Enterprises</p></div>
          <div><p className="text-xs" style={{ color: MUTED }}>State</p><p style={{ color: INK }}>{BUSINESS_STATE}</p></div>
          <div><p className="text-xs" style={{ color: MUTED }}>Financial year</p><p style={{ color: INK }}>FY {FY}</p></div>
          <div><p className="text-xs" style={{ color: MUTED }}>Invoice prefix</p><p style={{ fontFamily: "'IBM Plex Mono', monospace", color: INK }}>PYN/{FY}/####</p></div>
        </div>
      </div>

      <div className="rounded-2xl p-5" style={{ background: "white", border: `1px solid ${LINE}` }}>
        <div className="flex items-center gap-2 mb-3">
          <Phone size={16} color={ORANGE} />
          <h3 className="font-semibold text-sm" style={{ color: INK }}>Support</h3>
        </div>
        <p className="text-sm" style={{ color: INK }}>Need help with GST filing, invoices, or your account?</p>
        <p className="mt-2 text-lg font-semibold" style={{ fontFamily: "'IBM Plex Mono', monospace", color: ORANGE_DARK }}>070 6581 9819</p>
        <p className="text-xs mt-1" style={{ color: MUTED }}>Mon–Sat, 9:30 AM – 7:00 PM IST</p>
      </div>

      <div className="rounded-2xl p-5 flex items-center justify-between" style={{ background: "white", border: `1px solid ${LINE}` }}>
        <div>
          <h3 className="font-semibold text-sm" style={{ color: INK }}>App version</h3>
          <p className="text-xs mt-1" style={{ color: MUTED }}>Free to use, no activation required.</p>
        </div>
        <span className="text-xs font-semibold px-2.5 py-1 rounded-full" style={{ background: TEAL_TINT, color: TEAL_DARK, fontFamily: "'IBM Plex Mono', monospace" }}>v0.0.1</span>
      </div>
    </div>
  );
}

export default function PaynancialApp() {
  const [view, setView] = useState("dashboard");
  const [invoices, setInvoices] = useState(seedInvoices);
  const [parties, setParties] = useState(seedParties);
  const [mobileOpen, setMobileOpen] = useState(false);

  return (
    <div style={{ fontFamily: "'IBM Plex Sans', sans-serif", background: BG, minHeight: "100vh" }}>
      <div className="flex" style={{ minHeight: "100vh" }}>
        <Sidebar view={view} setView={setView} mobileOpen={mobileOpen} setMobileOpen={setMobileOpen} />
        <div className="flex-1 min-w-0">
          <div className="md:hidden flex items-center justify-between px-4 py-3" style={{ background: TEAL_DARK }}>
            <div className="flex items-center gap-2">
              <LogoMark size={26} />
              <Wordmark dark size={16} />
            </div>
            <button onClick={() => setMobileOpen(true)}><Menu size={20} color="white" /></button>
          </div>
          <TopBar setMobileOpen={setMobileOpen} setView={setView} />
          <div className="p-5 md:p-8">
            {view === "dashboard" && <Dashboard invoices={invoices} setView={setView} />}
            {view === "invoices" && <InvoiceList invoices={invoices} setInvoices={setInvoices} />}
            {view === "create" && <InvoiceForm parties={parties} invoices={invoices} setInvoices={setInvoices} setView={setView} />}
            {view === "parties" && <Parties parties={parties} setParties={setParties} />}
            {view === "items" && <Items />}
            {view === "settings" && <Settings />}
          </div>
        </div>
      </div>
    </div>
  );
}
