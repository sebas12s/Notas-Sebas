# Ejemplos de Next

## Navbar basico

```tsx
import { HomeIcon } from '@primer/octicons-react';
import Link from 'next/link';

const newItemsNav = [
  { path: '/about', title: 'About' },
  { path: '/pricing', title: 'Pricing' },
  { path: '/contact', title: 'Contact' },
];

export const Navbar = () => {
  return (
    <nav className='flex bg-emerald-800 bg-opacity-30 p-2 m-2 rounded justify-between'>
      <Link href={'/'} className='flex items-center'>
        <HomeIcon className='mr-2' />
        {/* libreria de icons */}
        <span className='w-1/2'>Marcela</span>
      </Link>

      <div className='w-1/2 flex justify-end'>
        {newItemsNav.map((item) => (
          <Link key={item.title} className='mr-2' href={item.path}>
            {item.title}
          </Link>
        ))}
      </div>
    </nav>
  );
};
```

## Active Link

Para saber en que ruta estamos y nuestro primer client component
