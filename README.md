# Replicating a Behavioral RCT: SMS Reminders and Forest Rule Compliance

A partial replication and extension of Eisenbarth, Graham & Rigterink (2021),
"Can Reminders of Rules Induce Compliance? Experimental Evidence from a
Common Pool Resource Setting," *Environmental and Resource Economics* 79(4).

I built this to make sure I actually understood the paper, not just its
abstract. I rebuilt their core household-level regressions from scratch in
R, translating from their original Stata replication code.

## The mechanism

The paper tests whether monthly SMS reminders about forest use rules change
behavior in villages that already have community monitoring in place.
Because every SMS-treatment village also had monitoring, the comparison
group has to be monitoring-only villages, not untreated ones. Otherwise
there'd be no way to isolate what the SMS specifically added on top of
monitoring.

What's actually interesting is the result: people's beliefs updated. They
came away thinking a rule-breaker was more likely to get caught, but their
actual behavior barely moved. The naive expectation, similar to a signaling
story in microeconomics where new information should feed directly into a
decision, is that if you believe you're more likely to be caught, you
should comply more. Here, that link mostly breaks down.

## What I reproduced

**Table 4, Column 3: perceived sanction probability.** SMS reminders raised
households' perceived likelihood of being sanctioned by 0.316 standard
deviations (my estimate: 0.316, p = 0.023; paper: 0.316, p = 0.022).

**Table 5, Column 1: actual non-compliance.** SMS reminders did *not*
translate into lower rule-breaking. If anything, there was a small, only
weakly significant increase (my estimate: 0.089; paper: 0.089, p = 0.027).

Together these reproduce the paper's central finding. The intervention
changed what people believed about enforcement risk, without changing what
they actually did.

## My extension

I tested whether the belief effect differs for households that border the
forest directly. My reasoning: bordering households already have more
everyday contact with monitoring and enforcement, so the real question is
whether an SMS reminder adds anything on top of that existing exposure, or
matters more for households with less of it.

The interaction between treatment and forest-border status came out at
0.012 (p = 0.97). No detectable difference. The SMS effect on perceived
sanction risk looks the same regardless of a household's proximity to the
resource.

## Open questions

- The paper offers a few candidate explanations for why the belief effect
  didn't carry over into behavior: income constraints on compliance, an
  intention-behavior gap, needing a critical mass of "conditional
  cooperators." I don't have a way to tell from this replication alone
  which one is actually doing the work.
- My forest-border extension came back null. I'm not sure whether that
  means the effect genuinely doesn't vary by exposure, or whether I just
  tested the wrong split. I'd want a second opinion on whether this is a
  real answer or a false negative from picking the wrong dimension.

## Data

Data and original Stata code from the authors' OSF repository:
https://osf.io/td2p3/. Raw data isn't included in this repo. Code only.

## Not yet done

- Village-level analysis (Table 6)
- Product-by-product breakdown checking whether the non-compliance index
  result is an artifact of index construction, as the paper itself suggests