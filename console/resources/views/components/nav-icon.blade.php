@props(['name', 'class' => 'h-5 w-5'])
@php
$paths = [
    'home' => '<path d="M3 11.5 12 4l9 7.5"/><path d="M5 10v9a1 1 0 001 1h4v-6h4v6h4a1 1 0 001-1v-9"/>',
    'chart' => '<path d="M4 19h16"/><path d="M7 19v-6M12 19V8M17 19v-10"/>',
    'inbox' => '<path d="M3 12h4l2 3h6l2-3h4"/><path d="M5 4h14l2 8v7a1 1 0 01-1 1H4a1 1 0 01-1-1v-7z"/>',
    'stamp' => '<circle cx="12" cy="8" r="4"/><path d="M8 12v4M16 12v4M4 20h16M6 16h12v4H6z"/>',
    'handshake' => '<path d="M2 12l5-4 4 3 3-3 8 4"/><path d="M6 13l3 3 3-3 3 3 4-4"/>',
    'users' => '<circle cx="9" cy="8" r="3"/><path d="M2 20v-1a5 5 0 015-5h4a5 5 0 015 5v1"/><circle cx="17" cy="8" r="3"/><path d="M17 12a5 5 0 015 5v3"/>',
    'currency' => '<circle cx="12" cy="12" r="9"/><path d="M9 15.5s.8 1.5 3 1.5 3-1 3-2.3c0-2.7-6-1.2-6-3.9C9 9.5 10.5 8.5 12 8.5s2.6.7 3 1.5M12 7v1.2M12 15.8V17"/>',
    'document' => '<path d="M7 3h7l4 4v13a1 1 0 01-1 1H7a1 1 0 01-1-1V4a1 1 0 011-1z"/><path d="M14 3v4h4"/><path d="M9 12h6M9 16h6"/>',
    'bar-chart' => '<rect x="4" y="12" width="4" height="8"/><rect x="10" y="7" width="4" height="13"/><rect x="16" y="3" width="4" height="17"/>',
    'shield' => '<path d="M12 3l7 3v6c0 4.5-3 7.5-7 9-4-1.5-7-4.5-7-9V6z"/><path d="M9 12l2 2 4-4"/>',
    'settings' => '<circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.7 1.7 0 00.3 1.9l.1.1a2 2 0 11-2.8 2.8l-.1-.1a1.7 1.7 0 00-1.9-.3 1.7 1.7 0 00-1 1.5V21a2 2 0 11-4 0v-.1a1.7 1.7 0 00-1-1.6 1.7 1.7 0 00-1.9.3l-.1.1a2 2 0 11-2.8-2.8l.1-.1a1.7 1.7 0 00.3-1.9 1.7 1.7 0 00-1.5-1H3a2 2 0 110-4h.1a1.7 1.7 0 001.5-1 1.7 1.7 0 00-.3-1.9l-.1-.1a2 2 0 112.8-2.8l.1.1a1.7 1.7 0 001.9.3H9a1.7 1.7 0 001-1.5V3a2 2 0 114 0v.1a1.7 1.7 0 001 1.5 1.7 1.7 0 001.9-.3l.1-.1a2 2 0 112.8 2.8l-.1.1a1.7 1.7 0 00-.3 1.9V9c.4.4 1 .7 1.5 1H21a2 2 0 110 4h-.1a1.7 1.7 0 00-1.5 1z"/>',
];
@endphp
<svg class="{{ $class }}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
    {!! $paths[$name] ?? $paths['document'] !!}
</svg>
