import { useCurrentUser } from "@lib/context";
import { Space } from "@prisma/client";
import Spaces from "components/Spaces";
import WithNavBar from "components/WithNavBar";
import type { GetServerSideProps, NextPage } from "next";
import Link from "next/link";
import { getEnhancedPrisma } from "server/enhanced-db";
import React, { useState } from "react";

type Props = {
  spaces: Space[];
};

interface IQuote {
  id: number;
  char: string;
  dialog: string;
  movie: string;
}

const Home: NextPage<Props> = ({ spaces }) => {
  const user = useCurrentUser();
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [quote, setQuote] = useState<IQuote>({
    id: 0,
    char: "",
    dialog: "",
    movie: "",
  });

  async function getQuote() {
    if (!isLoading) return null;
    try {
      let response = await fetch("/api/lotr/quote");
      let quote = await response.json();
      console.log(quote);
      setQuote(quote);
    } catch (error) {
      console.error(error);
    } finally {
      setIsLoading(false);
    }
  }

  getQuote();

  return (
    <WithNavBar>
      {user && (
        <div className="mt-8 text-center flex flex-col items-center w-full">
          <h1 className="text-2xl text-gray-800">
            Welcome {user.name || user.email}!
          </h1>
          {isLoading ? (
            "Loading..."
          ) : (
            <div>
              <figure className="max-w-screen-md mx-auto text-center">
                <svg
                  className="w-10 h-10 mx-auto mb-3 text-gray-400 dark:text-gray-600"
                  aria-hidden="true"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="currentColor"
                  viewBox="0 0 18 14"
                >
                  <path d="M6 0H2a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h4v1a3 3 0 0 1-3 3H2a1 1 0 0 0 0 2h1a5.006 5.006 0 0 0 5-5V2a2 2 0 0 0-2-2Zm10 0h-4a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h4v1a3 3 0 0 1-3 3h-1a1 1 0 0 0 0 2h1a5.006 5.006 0 0 0 5-5V2a2 2 0 0 0-2-2Z" />
                </svg>
                <blockquote>
                  <p className="text-2xl italic font-medium text-gray-900 dark:text-black">
                    "{quote.dialog}"
                  </p>
                </blockquote>
                <figcaption className="flex items-center justify-center mt-6 space-x-3">
                  <img
                    className="w-6 h-6 rounded-full"
                    src="/tolkien.jpg"
                    alt="J.R.R. Tolkien Logo"
                  />
                  <div className="flex items-center divide-x-2 divide-gray-500 dark:divide-gray-700">
                    <cite className="pr-3 font-medium text-gray-900 dark:text-black">
                      {quote.char}
                    </cite>
                    <cite className="pl-3 text-sm text-gray-500 dark:text-gray-400">
                      {quote.movie}
                    </cite>
                  </div>
                </figcaption>
              </figure>
            </div>
          )}
          <div className="w-full p-8">
            <h2 className="text-lg md:text-xl text-left mb-8 text-gray-700">
              Choose a space to start, or{" "}
              <Link href="/create-space" className="link link-primary">
                create a new one.
              </Link>
            </h2>
            <Spaces spaces={spaces} />
          </div>
        </div>
      )}
    </WithNavBar>
  );
};

export const getServerSideProps: GetServerSideProps<Props> = async (ctx) => {
  const db = await getEnhancedPrisma(ctx);
  const spaces = await db.space.findMany();
  return {
    props: { spaces },
  };
};

export default Home;
