<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>{{ $title ?? 'Dashboard' }} — {{ config('app.name') }}</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@500;600;700&display=swap" rel="stylesheet">

    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="font-sans antialiased bg-slate-50 text-slate-800">
<div class="min-h-screen flex">

    {{-- Sidebar --}}
    <aside class="w-64 shrink-0 bg-navy-950 text-white flex flex-col" style="background:#060f24">
        <div class="h-16 flex items-center gap-2.5 px-5 border-b border-white/10">
            <x-brand-mark class="h-6 w-auto" />
            <span class="font-head font-semibold text-[15px] tracking-tight">Videshia<span class="text-teal-400">.console</span></span>
        </div>

        <nav class="flex-1 overflow-y-auto py-4 px-3 space-y-0.5">
            @foreach (config('console_nav') as $item)
                @can($item['permission'])
                    @php
                        $routeName = $item['route'];
                        $params = $item['params'] ?? [];
                        $isActive = request()->routeIs($routeName) && (empty($params) || request()->route('module') === ($params['module'] ?? null));
                    @endphp
                    <a href="{{ route($routeName, $params) }}"
                       class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm transition
                              {{ $isActive ? 'bg-white/10 text-white font-medium' : 'text-slate-300 hover:bg-white/5 hover:text-white' }}">
                        <x-nav-icon :name="$item['icon']" class="h-[18px] w-[18px] shrink-0" />
                        <span class="flex-1">{!! $item['label'] !!}</span>
                        @unless($item['built'])
                            <span class="text-[9px] uppercase tracking-wide font-semibold px-1.5 py-0.5 rounded bg-white/10 text-slate-400">Soon</span>
                        @endunless
                    </a>
                @endcan
            @endforeach
        </nav>

        <div class="p-3 border-t border-white/10">
            <div class="px-3 py-2 text-[11px] text-slate-400 leading-relaxed">
                Milestone 1 — Foundation<br>Modules marked <b class="text-slate-300">Soon</b> ship in later milestones.
            </div>
        </div>
    </aside>

    {{-- Main --}}
    <div class="flex-1 flex flex-col min-w-0">
        <header class="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-6 shrink-0">
            <h1 class="font-head font-semibold text-[17px] text-navy-900" style="color:#0a1b3d">{{ $title ?? 'Dashboard' }}</h1>

            <div class="flex items-center gap-4">
                <span class="text-xs px-2.5 py-1 rounded-full bg-teal-100 text-teal-700" style="background:#e4faf9;color:#0b7a7e">
                    {{ auth()->user()->getRoleNames()->first() ?? 'No role' }}
                </span>
                <div class="relative">
                    <details class="group">
                        <summary class="list-none flex items-center gap-2 cursor-pointer">
                            <span class="h-8 w-8 rounded-full flex items-center justify-center text-white text-xs font-semibold" style="background:#1b4e9b">
                                {{ strtoupper(substr(auth()->user()->name ?? '?', 0, 1)) }}
                            </span>
                        </summary>
                        <div class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg border border-slate-200 py-1 z-10">
                            <div class="px-4 py-2 text-xs text-slate-500 border-b border-slate-100">{{ auth()->user()->email }}</div>
                            <form method="POST" action="{{ route('logout') }}">
                                @csrf
                                <button type="submit" class="w-full text-left px-4 py-2 text-sm text-slate-700 hover:bg-slate-50">Sign out</button>
                            </form>
                        </div>
                    </details>
                </div>
            </div>
        </header>

        <main class="flex-1 overflow-y-auto p-6">
            @if (session('flash'))
                <div class="mb-5 px-4 py-3 rounded-lg text-sm" style="background:#e4faf9;color:#0b7a7e;border:1px solid #b7ecea">
                    {{ session('flash') }}
                </div>
            @endif
            @if ($errors->any())
                <div class="mb-5 px-4 py-3 rounded-lg text-sm bg-rose-50 text-rose-700 border border-rose-200">
                    <ul class="list-disc pl-4 space-y-0.5">
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif
            {{ $slot }}
        </main>
    </div>
</div>
</body>
</html>
