import ChatWindow from '@/components/ChatWindow';
import { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Pesquisa — WMK Pesquisa IA',
  description: 'Pesquise na internet e converse com inteligência artificial.',
};

const Home = () => {
  return <ChatWindow />;
};

export default Home;
