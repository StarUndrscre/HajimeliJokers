SMODS.current_mod.credits_tab = function()
  local scale = 0.75
  return {
    n = G.UIT.ROOT,
    config = {
      align = "cm",
      padding = 0.05,
      colour = G.C.CLEAR
    },
    nodes = {
      {
        n = G.UIT.C,
        config = {
          minw = 8,
          minh = 4,
          colour = G.C.BLACK,
          padding = 0.15,
          align = "cm"
        },
        nodes = {
          {
            n = G.UIT.R,
            config = {
              colour = G.C.CLEAR,
              minw = 7,
              minh = 0.65,
              align = "cm",
              outline = 1,
              outline_colour = G.C.WHITE,
              r = 0.08
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = "Created by ",
                  shadow = true,
                  align = "cm",
                  scale = scale * 0.7,
                  colour = G.C.UI.TEXT_LIGHT,
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "Star",
                  shadow = true,
                  align = "cm",
                  scale = scale * 0.7,
                  colour = HEX("82b6ff"),
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "Undrscre",
                  shadow = true,
                  align = "cm",
                  scale = scale * 0.7,
                  colour = HEX("ffd482"),
                }
              }
            }
          },
          {
            n = G.UIT.R,
            nodes = {
              {
                n = G.UIT.C,
                config = {
                  colour = G.C.BLACK,
                  padding = 0.15,
                  align = "tl"
                },
                nodes = {
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "cm",
                      minw = 3.2,
                      minh = 0.6,
                      outline = 1,
                      outline_colour = G.C.WHITE,
                      r = 0.08
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "Joker Artists",
                          shadow = true,
                          align = "cm",
                          scale = scale * 0.7,
                          colour = G.C.UI.TEXT_LIGHT
                        },
                      }
                    }
                  },
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "tl",
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "Ryoko Amesapphi",
                          align = "cm",
                          shadow = true,
                          scale = scale * 0.5,
                          colour = G.C.UI.TEXT_LIGHT,
                          tooltip = {title = nil, text = {"- Diamonds in Hand", "- Hearts in Hand", "- Spades in Hand", "- Glitch"}}
                        }
                      }
                    }
                  },
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "tl",
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "DokiNabi",
                          align = "cm",
                          shadow = true,
                          scale = scale * 0.5,
                          colour = G.C.UI.TEXT_LIGHT,
                          tooltip = {title = nil, text = {"- Clubs in Hand"}}
                        }
                      }
                    }
                  },
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "tl",
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "stupid cat",
                          align = "cm",
                          shadow = true,
                          scale = scale * 0.5,
                          colour = G.C.UI.TEXT_LIGHT,
                          tooltip = {title = nil, text = {"- Dulce"}}
                        }
                      }
                    }
                  },
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "tl",
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "Inksurgence",
                          align = "cm",
                          shadow = true,
                          scale = scale * 0.5,
                          colour = G.C.UI.TEXT_LIGHT,
                          tooltip = {title = nil, text = {"- Round2 Pass", "- NESiCA Card"}}
                        }
                      }
                    }
                  },
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "tl",
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "Lumbud84",
                          align = "cm",
                          shadow = true,
                          scale = scale * 0.5,
                          colour = G.C.UI.TEXT_LIGHT,
                          tooltip = {title = nil, text = {"- e-amusement pass"}}
                        }
                      }
                    }
                  },
                }
              },
              {
                n = G.UIT.C,
                config = {
                  colour = G.C.BLACK,
                  padding = 0.15,
                  align = "tr"
                },
                nodes = {
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "cm",
                      minw = 3.2,
                      minh = 0.6,
                      outline = 1,
                      outline_colour = G.C.WHITE,
                      r = 0.08
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "Joker Owners",
                          shadow = true,
                          align = "tm",
                          scale = scale * 0.7,
                          colour = G.C.UI.TEXT_LIGHT
                        },
                      }
                    }
                  },
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "tr",
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "StarUndrscre",
                          align = "cm",
                          shadow = true,
                          scale = scale * 0.5,
                          colour = G.C.UI.TEXT_LIGHT,
                          tooltip = {title = nil, text = {"- Glitch", "- Spades in Hand"}}
                        }
                      },
                    }
                  },
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "tr",
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "FracturedStar",
                          align = "cm",
                          shadow = true,
                          scale = scale * 0.5,
                          colour = G.C.UI.TEXT_LIGHT,
                          tooltip = {title = nil, text = {"- Hearts in Hand"}}
                        }
                      },
                    }
                  },
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "tr",
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "stupid cat",
                          align = "cm",
                          shadow = true,
                          scale = scale * 0.5,
                          colour = G.C.UI.TEXT_LIGHT,
                          tooltip = {title = nil, text = {"- Dulce"}}
                        }
                      }
                    }
                  },
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "tr",
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "DokiNabi",
                          align = "cm",
                          shadow = true,
                          scale = scale * 0.5,
                          colour = G.C.UI.TEXT_LIGHT,
                          tooltip = {title = nil, text = {"- Clubs in Hand"}}
                        }
                      }
                    }
                  },
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "tr",
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "KONAMI",
                          align = "cm",
                          shadow = true,
                          scale = scale * 0.5,
                          colour = G.C.UI.TEXT_LIGHT,
                          tooltip = {title = nil, text = {"- e-amusement pass"}}
                        }
                      }
                    }
                  },
                  {
                    n = G.UIT.R,
                    config = {
                      colour = G.C.CLEAR,
                      align = "tr",
                    },
                    nodes = {
                      {
                        n = G.UIT.T,
                        config = {
                          text = "Taito",
                          align = "cm",
                          shadow = true,
                          scale = scale * 0.5,
                          colour = G.C.UI.TEXT_LIGHT,
                          tooltip = {title = nil, text = {"- NESiCA Card"}}
                        }
                      }
                    }
                  },
                }
              }
            }
          }
        }
      }
    }
  }
end